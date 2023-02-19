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

  debugger?(inputs: string): void;
}

/**
 * range function for numbers [a, .., b-1]
 *
 * @param {number} a
 * @param {number} b
 * @return {Array}
 */
function range(a: number, b: number) {
  const numbers = [];

  for (let i = a; i < b; i++) {
    numbers.push(i);
  }

  return numbers;
}

/**
 * Add a transition to the transition table.
 *
 * @param table - table to add transition
 * @param {number} inp - input character code
 * @param {number} state - current state
 * @param {number=} action - action to be taken
 * @param {number=} next - next state
 */
function addToTransitionTable(
  table: number[],
  inp: number,
  state: number,
  action: number = 0,
  next?: number
) {
  table[bit.blshift(state, 8) | inp] =
    bit.blshift(action | 0, 4) | (next === undefined ? state : next);
}

/**
 * Add multiple transitions to the transition table.
 *
 * @param table - table to add transition
 * @param {Array} inps - array of input character codes
 * @param {number} state - current state
 * @param {number=} action - action to be taken
 * @param {number=} next - next state
 */
function add_list(
  table: number[],
  inps: number[],
  state: number,
  action?: number,
  next?: number
) {
  for (let i = 0; i < inps.length; i++)
    addToTransitionTable(table, inps[i], state, action, next);
}

/** global definition of printables and executables */
const PRINTABLES = range(0x20, 0x7f);
let EXECUTABLES = range(0x00, 0x18);
EXECUTABLES.push(0x19);
EXECUTABLES = EXECUTABLES.concat(range(0x1c, 0x20));

/**
 * create the standard transition table - used by all parser instances
 *
 *     table[state << 8 | character code] = action << 4 | next state
 *
 *     - states are indices of STATES (0 to 13)
 *     - control character codes defined from 0 to 159 (C0 and C1)
 *     - actions are indices of ACTIONS (0 to 14)
 *     - any higher character than 159 is handled by the 'error' action
 */
const TRANSITION_TABLE: number[] = (function () {
  const t: number[] = [];

  // table with default transition [any] --> [error, GROUND]
  for (let state = 0; state < 14; ++state) {
    for (let code = 0; code < 160; ++code) {
      t[bit.blshift(state, 8) | code] = 16;
    }
  }

  // apply transitions
  // printables
  add_list(t, PRINTABLES, 0, 2);
  // global anywhere rules
  for (let state = 0; state < 14; ++state) {
    add_list(t, [0x18, 0x1a, 0x99, 0x9a], state, 3, 0);
    add_list(t, range(0x80, 0x90), state, 3, 0);
    add_list(t, range(0x90, 0x98), state, 3, 0);
    addToTransitionTable(t, 0x9c, state, 0, 0); // ST as terminator
    addToTransitionTable(t, 0x1b, state, 11, 1); // ESC
    addToTransitionTable(t, 0x9d, state, 4, 8); // OSC
    add_list(t, [0x98, 0x9e, 0x9f], state, 0, 7);
    addToTransitionTable(t, 0x9b, state, 11, 3); // CSI
    addToTransitionTable(t, 0x90, state, 11, 9); // DCS
  }
  // rules for executables and 7f
  add_list(t, EXECUTABLES, 0, 3);
  add_list(t, EXECUTABLES, 1, 3);
  addToTransitionTable(t, 0x7f, 1);
  add_list(t, EXECUTABLES, 8);
  add_list(t, EXECUTABLES, 3, 3);
  addToTransitionTable(t, 0x7f, 3);
  add_list(t, EXECUTABLES, 4, 3);
  addToTransitionTable(t, 0x7f, 4);
  add_list(t, EXECUTABLES, 6, 3);
  add_list(t, EXECUTABLES, 5, 3);
  addToTransitionTable(t, 0x7f, 5);
  add_list(t, EXECUTABLES, 2, 3);
  addToTransitionTable(t, 0x7f, 2);
  // osc
  addToTransitionTable(t, 0x5d, 1, 4, 8);
  add_list(t, PRINTABLES, 8, 5);
  addToTransitionTable(t, 0x7f, 8, 5);
  add_list(t, [0x9c, 0x1b, 0x18, 0x1a, 0x07], 8, 6, 0);
  add_list(t, range(0x1c, 0x20), 8, 0);
  // sos/pm/apc does nothing
  add_list(t, [0x58, 0x5e, 0x5f], 1, 0, 7);
  add_list(t, PRINTABLES, 7);
  add_list(t, EXECUTABLES, 7);
  addToTransitionTable(t, 0x7f, 7);
  addToTransitionTable(t, 0x9c, 7, 0, 0);
  // csi entries
  addToTransitionTable(t, 0x5b, 1, 11, 3);
  add_list(t, range(0x40, 0x7f), 3, 7, 0);
  add_list(t, range(0x30, 0x3a), 3, 8, 4);
  addToTransitionTable(t, 0x3b, 3, 8, 4);
  add_list(t, [0x3c, 0x3d, 0x3e, 0x3f], 3, 9, 4);
  add_list(t, range(0x30, 0x3a), 4, 8);
  addToTransitionTable(t, 0x3b, 4, 8);
  add_list(t, range(0x40, 0x7f), 4, 7, 0);
  add_list(t, [0x3a, 0x3c, 0x3d, 0x3e, 0x3f], 4, 0, 6);
  add_list(t, range(0x20, 0x40), 6);
  addToTransitionTable(t, 0x7f, 6);
  add_list(t, range(0x40, 0x7f), 6, 0, 0);
  addToTransitionTable(t, 0x3a, 3, 0, 6);
  add_list(t, range(0x20, 0x30), 3, 9, 5);
  add_list(t, range(0x20, 0x30), 5, 9);
  add_list(t, range(0x30, 0x40), 5, 0, 6);
  add_list(t, range(0x40, 0x7f), 5, 7, 0);
  add_list(t, range(0x20, 0x30), 4, 9, 5);
  // esc_intermediate
  add_list(t, range(0x20, 0x30), 1, 9, 2);
  add_list(t, range(0x20, 0x30), 2, 9);
  add_list(t, range(0x30, 0x7f), 2, 10, 0);
  add_list(t, range(0x30, 0x50), 1, 10, 0);
  add_list(
    t,
    [0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x59, 0x5a, 0x5c],
    1,
    10,
    0
  );
  add_list(t, range(0x60, 0x7f), 1, 10, 0);
  // dcs entry
  addToTransitionTable(t, 0x50, 1, 11, 9);
  add_list(t, EXECUTABLES, 9);
  addToTransitionTable(t, 0x7f, 9);
  add_list(t, range(0x1c, 0x20), 9);
  add_list(t, range(0x20, 0x30), 9, 9, 12);
  addToTransitionTable(t, 0x3a, 9, 0, 11);
  add_list(t, range(0x30, 0x3a), 9, 8, 10);
  addToTransitionTable(t, 0x3b, 9, 8, 10);
  add_list(t, [0x3c, 0x3d, 0x3e, 0x3f], 9, 9, 10);
  add_list(t, EXECUTABLES, 11);
  add_list(t, range(0x20, 0x80), 11);
  add_list(t, range(0x1c, 0x20), 11);
  add_list(t, EXECUTABLES, 10);
  addToTransitionTable(t, 0x7f, 10);
  add_list(t, range(0x1c, 0x20), 10);
  add_list(t, range(0x30, 0x3a), 10, 8);
  addToTransitionTable(t, 0x3b, 10, 8);
  add_list(t, [0x3a, 0x3c, 0x3d, 0x3e, 0x3f], 10, 0, 11);
  add_list(t, range(0x20, 0x30), 10, 9, 12);
  add_list(t, EXECUTABLES, 12);
  addToTransitionTable(t, 0x7f, 12);
  add_list(t, range(0x1c, 0x20), 12);
  add_list(t, range(0x20, 0x30), 12, 9);
  add_list(t, range(0x30, 0x40), 12, 0, 11);
  add_list(t, range(0x40, 0x7f), 12, 12, 13);
  add_list(t, range(0x40, 0x7f), 10, 12, 13);
  add_list(t, range(0x40, 0x7f), 9, 12, 13);
  add_list(t, EXECUTABLES, 13, 13);
  add_list(t, PRINTABLES, 13, 13);
  addToTransitionTable(t, 0x7f, 13);
  add_list(t, [0x1b, 0x9c], 13, 14, 0);

  return t;
})();

class TerminalParser {
  private initial_state = 0; // 'GROUND' is default
  private current_state = this.initial_state | 0;
  private transitions = [...TRANSITION_TABLE];
  private osc = "";
  private params: number[] = [0];
  private collected = "";
  private callbacks: ITerminal;

  constructor(callbacks: ITerminal) {
    this.callbacks = callbacks;
  }

  /**
   * Reset the parser.
   */
  reset() {
    this.current_state = this.initial_state | 0;
    this.osc = "";
    this.params = [0];
    this.collected = "";
  }

  /**
   * Parse the input string
   */
  parse(s: string) {
    let code = 0,
      transition = 0,
      error = false,
      current_state = this.current_state | 0;

    // local buffers
    let printed = -1;
    let dcs = -1;
    let osc = this.osc;
    let collected = this.collected;
    let params = this.params;

    // process input string
    for (let i = 0, l = s.length | 0; i < l; ++i) {
      code = s.charCodeAt(i) | 0;
      // shortcut for most chars (print action)
      if (current_state === 0 && code > 0x1f && code < 0x80) {
        printed = printed >= 0 ? printed | 0 : i | 0;
      } else {
        transition =
          (code < 0xa0
            ? this.transitions[bit.blshift(current_state, 8) | code | 0] | 0
            : 16) | 0;

        switch (bit.brshift(transition, 4) | 0) {
          case 2: // print
            printed = printed + 1 !== 0 ? printed | 0 : i | 0;
            break;
          case 3: // execute
            if (printed >= 0) {
              this.callbacks.inst_p?.(s.substring(printed, i));
              printed = -1;
            }
            this.callbacks.inst_x?.(String.fromCharCode(code));
            break;
          case 0: // ignore
            // handle leftover print and dcs chars
            if (printed >= 0) {
              this.callbacks.inst_p?.(s.substring(printed, i));
              printed = -1;
            } else if (dcs + 1 !== 0) {
              this.callbacks.inst_P?.(s.substring(dcs, i));
              dcs = -1;
            }
            break;
          case 1: // error
            // handle unicode chars in write buffers w'o state change
            if (code > 0x9f) {
              switch (current_state) {
                case 0: // GROUND -> add char to print string
                  printed = !(printed + 1) ? i | 0 : printed | 0;
                  break;
                case 8: // OSC_STRING -> add char to osc string
                  osc += String.fromCharCode(code);
                  transition = transition | 8 | 0;
                  break;
                case 6: // CSI_IGNORE -> ignore char
                  transition = transition | 6 | 0;
                  break;
                case 11: // DCS_IGNORE -> ignore char
                  transition = transition | 11 | 0;
                  break;
                case 13: // DCS_PASSTHROUGH -> add char to dcs
                  if (!(dcs + 1)) dcs = i | 0;
                  transition = transition | 13 | 0;
                  break;
                default: // real error
                  error = true;
              }
            } else {
              // real error
              error = true;
            }
            if (error) {
              if (
                this.callbacks.inst_E?.({
                  pos: i, // position in parse string
                  character: String.fromCharCode(code), // wrong character
                  state: current_state, // in state
                  print: printed, // print buffer
                  dcs: dcs, // dcs buffer
                  osc: osc, // osc buffer
                  collect: collected, // collect buffer
                  params: params, // params buffer
                })
              ) {
                return;
              }
              error = false;
            }
            break;
          case 7: // csi_dispatch
            this.callbacks.inst_c?.(
              collected,
              params,
              String.fromCharCode(code)
            );
            break;
          case 8: // param
            if (code === 0x3b) params.push(0);
            else
              params[params.length - 1] =
                (params[params.length - 1] * 10 + code - 48) | 0;
            break;
          case 9: // collect
            collected += String.fromCharCode(code);
            break;
          case 10: // esc_dispatch
            this.callbacks.inst_e?.(collected, String.fromCharCode(code));
            break;
          case 11: // clear
            if (printed >= 0) {
              this.callbacks.inst_p?.(s.substring(printed, i));
              printed = -1;
            }
            osc = "";
            params = [0];
            collected = "";
            dcs = -1;
            break;
          case 12: // dcs_hook
            this.callbacks.inst_H?.(
              collected,
              params,
              String.fromCharCode(code)
            );
            break;
          case 13: // dcs_put
            if (!(dcs + 1)) dcs = i | 0;
            break;
          case 14: // dcs_unhook
            if (dcs >= 0) {
              this.callbacks.inst_P?.(s.substring(dcs, i));
            }
            this.callbacks.inst_U();
            if (code === 0x1b) transition = transition | 1 | 0;
            osc = "";
            params = [0];
            collected = "";
            dcs = -1;
            break;
          case 4: // osc_start
            if (printed !== -1) {
              this.callbacks.inst_p?.(s.substring(printed, i));
              printed = -1;
            }
            osc = "";
            break;
          case 5: // osc_put
            osc += s.charAt(i);
            break;
          case 6: // osc_end
            if (osc && code !== 0x18 && code !== 0x1a)
              this.callbacks.inst_o?.(osc);
            if (code === 0x1b) transition = transition | 1 | 0;
            osc = "";
            params = [0];
            collected = "";
            dcs = -1;
            break;
        }
      }

      current_state = (transition & 15) | 0;
    }

    this.callbacks.debugger?.(`awoo state=${current_state} printed=${printed}`);

    // push leftover pushable buffers to terminal
    if (current_state === 0 && printed >= 0) {
      this.callbacks.inst_p?.(s.substring(printed));
    } else if (current_state === 13 && dcs >= 0) {
      this.callbacks.inst_P?.(s.substring(dcs));
    }

    // save non pushable buffers
    this.osc = osc;
    this.collected = collected;
    this.params = params;

    // save state
    this.current_state = current_state | 0;
  }
}

export { TerminalParser };
export type { ITerminal };
