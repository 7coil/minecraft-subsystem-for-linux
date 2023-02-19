import { findBackground, findForeground } from "./colourMapping";
import { JASON } from "./JASON";
import { PacketCrafter } from "./Packet";
import { ITerminal } from "./TerminalParser";

class BufferlessFrame implements ITerminal {
  private readonly topPane: Window;
  private readonly bottomPane: Window;
  private readonly scrollPane: Window;
  private readonly websocket: lWebSocket;

  private marginTop: number;
  private marginBottom: number;

  private savedX: number = -1;
  private savedY: number = -1;

  constructor(websocket: lWebSocket) {
    this.websocket = websocket;
    const [screenWidth, screenHeight] = term.getSize();
    this.marginTop = 0;
    this.marginBottom = screenHeight;

    this.topPane = window.create(term.current(), 1, 1, 1, 1);
    this.scrollPane = window.create(term.current(), 1, 1, 1, 1);
    this.bottomPane = window.create(term.current(), 1, 1, 1, 1);

    this.scrollPane.clear();
    this.topPane.clear();
    this.bottomPane.clear();

    this.scrollPane.setCursorBlink(true);
    this.topPane.setCursorBlink(true);
    this.bottomPane.setCursorBlink(true);

    this.syncPaneSizes();
    this.setCursorPos(1, 1);
    this.syncPanePositions(1, 1);
  }

  private syncPaneSizes() {
    const [screenWidth, screenHeight] = term.getSize();

    this.topPane.reposition(1, 1, screenWidth, this.marginTop);
    this.scrollPane.reposition(
      1,
      this.marginTop + 1,
      screenWidth,
      this.marginBottom - this.marginTop
    );
    this.bottomPane.reposition(
      1,
      this.marginBottom,
      screenWidth,
      screenHeight - this.marginBottom
    );
  }

  private syncPanePositions(xPos: number, yPos: number) {
    this.topPane.setCursorPos(xPos, yPos);
    this.bottomPane.setCursorPos(xPos, yPos - this.marginBottom);
    this.scrollPane.setCursorPos(xPos, yPos - this.marginTop);
  }

  private setCursorPos(x: number, y: number) {
    const [screenX, screenY] = term.getSize();

    if (x <= 0) x = 1;
    if (y <= 0) y = 1;
    if (x > screenX) x = screenX;
    if (y > screenY) y = screenY;

    term.setCursorPos(x, y);
    this.syncPanePositions(x, y);
    term.setCursorPos(x, y);
  }

  write(input: string) {
    const [xPos, yPos] = term.getCursorPos();
    this.syncPanePositions(xPos, yPos);

    // If within the top margin, draw in the top pane
    if (yPos <= this.marginTop) {
      this.topPane.write(input);
      const [newXPos, newYPos] = this.topPane.getCursorPos();
      this.setCursorPos(newXPos, newYPos);
    } else if (yPos > this.marginBottom) {
      this.bottomPane.write(input);
      const [newXPos, newYPos] = this.bottomPane.getCursorPos();
      this.setCursorPos(newXPos, newYPos + this.marginBottom);
    } else {
      this.scrollPane.write(input);
      const [newXPos, newYPos] = this.scrollPane.getCursorPos();
      this.setCursorPos(newXPos, newYPos + this.marginTop);
    }
  }

  public inst_p(input: string) {
    this.write(input);
  }
  public inst_o(s: string) {}
  public inst_x(flag: string) {
    const [cursorX, cursorY] = this.scrollPane.getCursorPos();
    const [screenX, screenY] = this.scrollPane.getSize();

    if (flag === "\n") {
      if (cursorY >= screenY) {
        this.scrollPane.scroll(1);
        this.setCursorPos(1, cursorY);
      } else {
        this.setCursorPos(1, cursorY + 1);
      }
    } else if (flag === "\r") {
      this.setCursorPos(1, cursorY);
    } else if (flag === "\b") {
      if (cursorX === 1) {
        this.setCursorPos(screenX, Math.max(1, cursorY - 1));
      } else {
        this.setCursorPos(Math.max(1, cursorX - 1), cursorY);
      }
    } else if (flag === "\x07") {
      const speaker = peripheral.find("speaker") as any as speakerPeripheral;
      speaker?.playSound("minecraft:block.bell.use");
    } else if (flag === "\x11") {
      for (const side of redstone.getSides()) {
        redstone.setOutput(side, true)
      }
    } else if (flag === "\x13") {
      for (const side of redstone.getSides()) {
        redstone.setOutput(side, false)
      }
    }
  }
  public inst_c(collected: string, params: number[], flag: string) {
    if (flag === "K") {
      // From cursor to end of line           ESC [ K or ESC [ 0 K
      // From beginning of line to cursor     ESC [ 1 K
      // Entire line containing cursor        ESC [ 2 K
      const [param] = params;
      const [cursorX, cursorY] = term.getCursorPos();
      const [screenWidth, screenHeight] = term.getSize();

      if (params.length === 0 || param === 0) {
        for (let i = cursorX; i <= screenWidth; i++) {
          this.setCursorPos(i, cursorY);
          this.write(" ");
        }
        this.setCursorPos(cursorX, cursorY);
      } else if (param === 1) {
        for (let i = 1; i <= cursorX; i++) {
          this.setCursorPos(i, cursorY);
          this.write(" ");
        }
        this.setCursorPos(cursorX, cursorY);
      } else if (param === 2) {
        term.clearLine();
      }
    } else if (flag === "J") {
      // From cursor to end of screen         ESC [ J or ESC [ 0 J
      // From beginning of screen to cursor   ESC [ 1 J
      // Entire screen                        ESC [ 2 J
      const [param] = params;
      const [cursorX, cursorY] = term.getCursorPos();
      const [screenWidth, screenHeight] = term.getSize();

      if (params.length === 0 || param === 0) {
        for (let i = cursorY; i <= screenHeight; i++) {
          this.setCursorPos(1, i);
          term.clearLine();
        }
        for (let i = cursorX; i <= screenWidth; i++) {
          this.setCursorPos(i, cursorY);
          this.write(" ");
        }
        this.setCursorPos(cursorX, cursorY);
      } else if (param === 1) {
        for (let i = 1; i < cursorY; i++) {
          this.setCursorPos(1, i);
          term.clearLine();
        }
        for (let i = 1; i < cursorX; i++) {
          this.setCursorPos(i, cursorY);
          this.write(" ");
        }
        this.setCursorPos(cursorX, cursorY);
      } else if (param === 2) {
        this.topPane.clear();
        this.scrollPane.clear();
        this.bottomPane.clear();
        term.clear();
        this.setCursorPos(cursorX, cursorY);
      }
    } else if (flag === "H" || flag === "f") {
      let [row, col] = params;
      if (typeof row !== "number") row = 0;
      if (typeof col !== "number") col = 0;
      if (row < 0) row = 0;
      if (col < 0) col = 0;

      this.setCursorPos(col + 1, row + 1);
    } else if (
      flag === "A" ||
      flag === "B" ||
      flag === "C" ||
      flag === "D" ||
      flag === "E" ||
      flag === "F" ||
      flag === "G"
    ) {
      const [posX, posY] = term.getCursorPos();
      let x = posX;
      let y = posY;
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
      if (x < 1) x = 1;
      if (y < 1) y = 1;
      this.setCursorPos(x, y);
    } else if (flag === "m") {
      params.forEach((param) => {
        const newBackground = findBackground(param);
        const newForeground = findForeground(param);
        if (param === 0) {
          this.scrollPane.setBackgroundColour(colours.black);
          this.topPane.setBackgroundColour(colours.black);
          this.bottomPane.setBackgroundColour(colours.black);
          this.scrollPane.setTextColour(colours.white);
          this.topPane.setTextColour(colours.white);
          this.bottomPane.setTextColour(colours.white);
        } else if (newBackground) {
          this.scrollPane.setBackgroundColor(newBackground);
          this.topPane.setBackgroundColor(newBackground);
          this.bottomPane.setBackgroundColor(newBackground);
        } else if (newForeground) {
          this.scrollPane.setTextColor(newForeground);
          this.topPane.setTextColor(newForeground);
          this.bottomPane.setTextColor(newForeground);
        }
      });
    } else if (flag === "r") {
      const [cursorX, cursorY] = term.getCursorPos();
      const [marginTop, marginBottom] = params;
      this.marginTop = marginTop;
      this.marginBottom = marginBottom;
      this.syncPaneSizes();
      this.setCursorPos(cursorX, cursorY);
      this.syncPanePositions(cursorX, cursorY);
    }
  }
  public inst_e(collected: string, flag: string) {
    if (collected === "" && flag === "7") {
      const [cursorX, cursorY] = term.getCursorPos();
      this.savedX = cursorX;
      this.savedY = cursorY;
    }
    if (collected === "" && flag === "8") {
      if (this.savedX > 0 && this.savedY > 0) {
        term.setCursorPos(this.savedX, this.savedY);
        this.syncPanePositions(this.savedX, this.savedY);
      }
    }
  }
  public inst_H(collected: string, params: number[], flag: string) {}
  public inst_P(data: string) {}
  public inst_U() {}
  public complete() {}

  public destroy() {
    // this.window.setVisible(false);
  }
}

export { BufferlessFrame };
