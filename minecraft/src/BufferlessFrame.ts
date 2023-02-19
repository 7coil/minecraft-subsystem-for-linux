import { findBackground, findForeground } from "./colourMapping";
import { JASON } from "./JASON";
import { PacketCrafter } from "./Packet";
import { ITerminal } from "./TerminalParser";

class BufferlessFrame implements ITerminal {
  private readonly scrollPane: Window;
  private readonly websocket: lWebSocket;

  private marginTop: number;
  private marginBottom: number;

  constructor(websocket: lWebSocket) {
    this.websocket = websocket;
    const [screenWidth, screenHeight] = term.getSize()
    this.scrollPane = window.create(term.current(), 1, 1, screenWidth, screenHeight)
    this.marginTop = 1;
    this.marginBottom = screenHeight;
    this.scrollPane.clear()
    this.scrollPane.setCursorBlink(true);
  }

  getAbsoluteCursorPosition() {
    const [xPos, yPos] = this.scrollPane.getCursorPos();
    return [xPos, yPos + this.marginTop]
  }

  public inst_p(input: string) {
    this.websocket.send(PacketCrafter.debug({ d: "inst_p " + input }));
    this.scrollPane.write(input);
  }
  public inst_o(s: string) {}
  public inst_x(flag: string) {
    this.websocket.send(PacketCrafter.debug({ d: "inst_x " + flag }));

    const [cursorX, cursorY] = this.scrollPane.getCursorPos();
    const [screenX, screenY] = this.scrollPane.getSize();

    if (flag === "\n") {
      // print();
      if (cursorY === screenY) {
        this.scrollPane.scroll(1);
        this.scrollPane.setCursorPos(1, cursorY);
      } else {
        this.scrollPane.setCursorPos(1, cursorY + 1);
      }
    } else if (flag === "\r") {
      this.scrollPane.setCursorPos(1, cursorY);
    } else if (flag === "\b") {
      if (cursorX === 1) {
        this.scrollPane.setCursorPos(screenX, cursorY - 1);
      } else {
        this.scrollPane.setCursorPos(cursorX - 1, cursorY);
      }
    } else if (flag === "\x07") {
      // const speaker = peripheral.find("speaker");
      // speaker.playSound("minecraft:block.bell.use");
    } else if (flag === "\x00") {
      // write(' ')
    }
  }
  public inst_c(collected: string, params: number[], flag: string) {
    this.websocket.send(
      PacketCrafter.debug({ d: JASON.stringify({ collected, params, flag }) })
    );

    if (flag === "K") {
      // From cursor to end of line           ESC [ K or ESC [ 0 K
      // From beginning of line to cursor     ESC [ 1 K
      // Entire line containing cursor        ESC [ 2 K
      const [param] = params;
      const [cursorX, cursorY] = this.scrollPane.getCursorPos();
      const [screenWidth, screenHeight] = this.scrollPane.getSize();

      if (params.length === 0 || param === 0) {
        for (let i = cursorX; i <= screenWidth; i++) {
          this.scrollPane.setCursorPos(i, cursorY);
          this.scrollPane.write(" ");
        }
        this.scrollPane.setCursorPos(cursorX, cursorY);
      } else if (param === 1) {
        for (let i = 1; i <= cursorX; i++) {
          this.scrollPane.setCursorPos(i, cursorY);
          this.scrollPane.write(" ");
        }
        this.scrollPane.setCursorPos(cursorX, cursorY);
      } else if (param === 2) {
        this.scrollPane.clearLine();
      }
    } else if (flag === "J") {
      // From cursor to end of screen         ESC [ J or ESC [ 0 J
      // From beginning of screen to cursor   ESC [ 1 J
      // Entire screen                        ESC [ 2 J
      const [param] = params;
      const [cursorX, cursorY] = this.scrollPane.getCursorPos();
      const [screenWidth, screenHeight] = this.scrollPane.getSize();

      if (params.length === 0 || param === 0) {
        for (let i = cursorY; i <= screenHeight; i++) {
          this.scrollPane.setCursorPos(1, i);
          this.scrollPane.clearLine();
        }
        for (let i = cursorX; i <= screenWidth; i++) {
          this.scrollPane.setCursorPos(i, cursorY);
          this.scrollPane.write(" ");
        }
        this.scrollPane.setCursorPos(cursorX, cursorY);
      } else if (param === 1) {
        for (let i = 1; i < cursorY; i++) {
          this.scrollPane.setCursorPos(1, i);
          this.scrollPane.clearLine();
        }
        for (let i = 1; i < cursorX; i++) {
          this.scrollPane.setCursorPos(i, cursorY);
          this.scrollPane.write(" ");
        }
        this.scrollPane.setCursorPos(cursorX, cursorY);
      } else if (param === 2) {
        this.scrollPane.clear();
      }
    } else if (flag === "H" || flag === "f") {
      const [screenWidth, screenHeight] = this.scrollPane.getSize();
      let [row, col] = params;
      if (typeof col !== "number") col = 0;
      if (typeof row !== "number") row = 0;
      if (col >= screenWidth) col = screenWidth - 1;
      if (row >= screenHeight) row = screenHeight - 1;

      this.scrollPane.setCursorPos(col + 1, row + 1);
    } else if (
      flag === "A" ||
      flag === "B" ||
      flag === "C" ||
      flag === "D" ||
      flag === "E" ||
      flag === "F" ||
      flag === "G"
    ) {
      let [x, y] = this.scrollPane.getCursorPos();
      const [amount] = params;
      if (flag === "A") y -= amount;
      if (flag === "B") y += amount;
      if (flag === "C") x += amount;
      if (flag === "D") x -= amount;
      if (flag === "E") {
        x = 1;
        y += amount;
      }
      if (flag === "F") {
        x = 1;
        y -= amount;
      }
      if (flag === "G") {
        x = amount;
      }
      this.scrollPane.setCursorPos(x, y);
    } else if (flag === "m") {
      params.forEach((param) => {
        const newBackground = findBackground(param);
        const newForeground = findForeground(param);
        if (param === 0) {
          this.scrollPane.setBackgroundColour(colours.black);
          this.scrollPane.setTextColour(colours.white);
        } else if (newBackground) {
          this.scrollPane.setBackgroundColor(newBackground);
        } else if (newForeground) {
          this.scrollPane.setTextColor(newForeground);
        }
      });
    } else if (flag === "r") {
      const [topMargin, bottomMargin] = params;
      const [screenWidth, screenHeight] = this.scrollPane.getSize();
      this.scrollPane.reposition(1, topMargin + 1, screenWidth, bottomMargin - topMargin);
    }
  }
  public inst_e(collected: string, flag: string) {}
  public inst_H(collected: string, params: number[], flag: string) {}
  public inst_P(data: string) {}
  public inst_U() {}
  public complete() {
    // Finished rendering a single "parse" :)
  }

  public destroy() {
    // this.window.setVisible(false);
  }
}

export { BufferlessFrame };
