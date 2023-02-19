import WebSocket from 'ws';
import { TerminalParser } from "./TerminalParser";

const parser = new TerminalParser({
  inst_U() {
    console.log("inst_U")
  },
  inst_c(collected, params, flag) {
    console.log("inst_c", collected, params, flag)
  },
  inst_e(collected, flag) {
    console.log("inst_e", collected, flag)
  },
  inst_H(collected, params, flag) {
    console.log("inst_H", collected, params, flag)
  },
  inst_o(s) {
    console.log("inst_o", s)
  },
  inst_P(data) {
    console.log("inst_P", data)
  },
  inst_p(stringToPrint) {
    console.log("inst_p", stringToPrint)
  },
  inst_x(flag) {
    console.log("inst_x", flag)
  },
})

const ws = new WebSocket('ws://127.0.0.1:8080');

ws.on("message", (data) => {
  parser.parse(data.toString("utf-8"));
})
