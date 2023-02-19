"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const ws_1 = __importDefault(require("ws"));
const TerminalParser_1 = require("./TerminalParser");
const parser = new TerminalParser_1.TerminalParser({
    inst_U() {
        console.log("inst_U");
    },
    inst_c(collected, params, flag) {
        console.log("inst_c", collected, params, flag);
    },
    inst_e(collected, flag) {
        console.log("inst_e", collected, flag);
    },
    inst_H(collected, params, flag) {
        console.log("inst_H", collected, params, flag);
    },
    inst_o(s) {
        console.log("inst_o", s);
    },
    inst_P(data) {
        console.log("inst_P", data);
    },
    inst_p(stringToPrint) {
        console.log("inst_p", stringToPrint);
    },
    inst_x(flag) {
        console.log("inst_x", flag);
    },
});
const ws = new ws_1.default('ws://127.0.0.1:8080');
ws.on("message", (data) => {
    parser.parse(data.toString("utf-8"));
});
