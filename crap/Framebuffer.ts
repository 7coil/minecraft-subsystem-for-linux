import { ITerminal } from "./TerminalParser";

abstract class Vector {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

enum Colour {
  WHITE = 0x1,
  ORANGE = 0x2,
  MAGENTA = 0x4,
  LIGHT_BLUE = 0x8,
  YELLOW = 0x10,
  LIME = 0x20,
  PINK = 0x40,
  GREY = 0x80,
  LIGHT_GREY = 0x100,
  CYAN = 0x200,
  PURPLE = 0x400,
  BLUE = 0x800,
  BROWN = 0x1000,
  GREEN = 0x2000,
  RED = 0x4000,
  BLACK = 0x8000,
}

class Cursor extends Vector {
  private readonly width: number;
  private readonly height: number;

  constructor(width: number, height: number) {
    super(0, 0);
    this.width = width;
    this.height = height;
  }

  moveTo(x: number, y: number) {
    if (x < 0 || x >= this.width || y < 0 || y >= this.height) {
      throw new Error("Cursor moved outside of the framebuffer area.");
    }

    this.x = x;
    this.y = y;
  }

  moveLeft() {
    if (this.x > 0) this.x--;
  }

  moveRight() {
    if (this.x < this.width - 1) this.x++;
  }

  moveUp() {
    if (this.y > 0) this.y--;
  }

  moveDown() {
    if (this.y < this.height - 1) this.y++;
  }
}

class Character extends Vector {
  private value: string = " ";
  private fgColour: Colour = Colour.WHITE;
  private bgColour: Colour = Colour.BLACK;

  constructor(x: number, y: number) {
    super(x, y);
  }

  setValue(char: string) {
    if (char.length === 0) this.value = " ";
    if (char.length === 1) this.value = char;
    throw new Error("Cannot assign more than one character to a Character.");
  }

  setForegroundColour(colour?: Colour) {
    this.fgColour = colour ?? Colour.WHITE;
  }

  setBackgroundColour(colour?: Colour) {
    this.bgColour = colour ?? Colour.BLACK;
  }

  getInfo() {
    return {
      value: this.value,
      bg: this.bgColour,
      fg: this.fgColour,
    };
  }
}

class Framebuffer implements ITerminal {
  public readonly width: number;
  public readonly height: number;
  private readonly framebuffer: Character[] = [];
  private readonly cursor: Cursor = new Cursor(0, 0);

  constructor(width: number, height: number) {
    this.width = width;
    this.height = height;

    for (let x = 0; x < height; x++) {
      for (let y = 0; y < width; y++) {
        this.framebuffer.push(new Character(x, y));
      }
    }
  }

  private getCharacter(x: number, y: number) {
    if (x < 0 || x >= this.width || y < 0 || y >= this.height) {
      throw new Error("Selected a character outside of the frame buffer area.");
    }
    return this.framebuffer[x + y * this.width];
  }

  private writeString(input: string) {
    for (let i = 0; i < input.length; i++) {
      const currentCharacter = this.getCharacter(this.cursor.x + i, this.cursor.y);
      currentCharacter.setValue(input[i]);
      this.cursor.moveRight();
    }
  }

  public inst_p(input: string) {
    this.writeString(input)
  }
  public inst_o(s: string) {}
  public inst_x(flag: string) {}
  public inst_c(collected: string, params: number[], flag: string) {}
  public inst_e(collected: string, flag: string) {}
  public inst_H(collected: string, params: number[], flag: string) {}
  public inst_P(data: string) {}
  public inst_U() {}
  public complete() {
    
  }
}

export { Framebuffer }
