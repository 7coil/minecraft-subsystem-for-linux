"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.log = exports.JASON = void 0;
const JASON = JSON;
exports.JASON = JASON;
const log = (data) => console.log(JASON.stringify(data));
exports.log = log;
