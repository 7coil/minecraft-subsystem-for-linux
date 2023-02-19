"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PacketCrafter = void 0;
const JASON_1 = require("./JASON");
class PacketCrafter {
    static make(id, data) {
        return JASON_1.JASON.stringify({
            id,
            data,
        });
    }
    static keypress(data) {
        return PacketCrafter.make("k", data);
    }
    static writeToTerminal(data) {
        return PacketCrafter.make("w", data);
    }
    static connect(data) {
        return PacketCrafter.make("connect", data);
    }
}
exports.PacketCrafter = PacketCrafter;
