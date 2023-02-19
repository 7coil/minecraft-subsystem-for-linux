declare module "node-ansiparser" {
  interface ITerminal {

    /**
     * Print string "stringToPrint"
     */
    inst_p(stringToPrint: string): void;

    /**
     * OSC call
     */
    inst_o(s: number): void;

    /**
     * Trigger one character method
     */
    inst_x(flag: string): void;

    /**
     * Trigger CSI method
     */
    inst_c(collected: any, params: any, flag: any): void;

    /**
     * Trigger ESC method
     */
    inst_e(collected: any, flag: any): void;

    /**
     * DCS Command (hook)
     */
    inst_H(collected: any, params: any, flag: any): void;

    /**
     * DCS put
     */
    inst_P(data: any): void;

    /**
     * DCS Unhook
     */
    inst_U(): void;
  }

  class AnsiParser{
    constructor(terminal: ITerminal)
    parse(input: string): void;
  }

  export default AnsiParser;
}
