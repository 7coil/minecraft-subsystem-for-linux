"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const node_pty_1 = require("node-pty");
const ws_1 = require("ws");
const Packet_1 = require("./Packet");
const webSocketServer = new ws_1.WebSocketServer({
    port: 8080,
});
webSocketServer.on("connection", (socket) => {
    let docker = null;
    socket.on("close", () => {
        docker === null || docker === void 0 ? void 0 : docker.kill();
    });
    socket.on("message", (data) => {
        const parsed = JSON.parse(data);
        console.log(parsed);
        switch (parsed.id) {
            case "k":
                docker === null || docker === void 0 ? void 0 : docker.write(parsed.data.d);
                break;
            case "connect":
                docker = (0, node_pty_1.spawn)("docker", ["run", "-it", parsed.data.image, "/bin/bash"], {
                    name: "computercraft",
                    cols: parsed.data.width,
                    rows: parsed.data.height,
                });
                docker.onData((data) => {
                    const txData = Packet_1.PacketCrafter.writeToTerminal({ d: data });
                    console.log(txData);
                    socket.send(txData);
                });
                docker.onExit(() => {
                    socket.close();
                });
                break;
        }
    });
    socket.on("error", () => {
        docker === null || docker === void 0 ? void 0 : docker.kill();
        socket.close();
    });
});
