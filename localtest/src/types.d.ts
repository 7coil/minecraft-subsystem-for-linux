declare module "node-ansiparser" {
  interface ITerminal {
    /**
     * Print string "stringToPrint"
     */
    inst_p?(stringToPrint: string): void;
  
    /**
     * OSC call
     */
    inst_o?(s: string): void;
  
    /**
     * Trigger one character method
     */
    inst_x?(flag: string): void;
  
    /**
     * Trigger CSI method
     */
    inst_c?(collected: string, params: number[], flag: string): void;
  
    /**
     * Trigger ESC method
     */
    inst_e?(collected: string, flag: string): void;
  
    /**
     * DCS Command (hook)
     */
    inst_H?(collected: string, params: number[], flag: string): void;
  
    /**
     * DCS put
     */
    inst_P?(data: string): void;
  
    /**
     * DCS Unhook
     */
    inst_U(): void;
  
    /**
     * Who the fuck knows?!
     */
    inst_E?(error: {
      pos: number;
      character: string;
      state: number;
      print: number;
      dcs: number;
      osc: string;
      collect: string;
      params: number[];
    }): boolean;
  }

  class AnsiParser {
    constructor(terminal: ITerminal)
    clear(): void;
    parse(input: string): void;
  }

  export default AnsiParser;
}
