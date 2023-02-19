"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const child_process_1 = require("child_process");
const node_pty_1 = require("node-pty");
const ws_1 = require("ws");
const Packet_1 = require("./Packet");
const webSocketServer = new ws_1.WebSocketServer({
    port: 80,
});
webSocketServer.on("connection", (socket) => {
    let docker = null;
    socket.on("message", (data) => {
        var _a;
        const parsed = JSON.parse(data);
        console.log(parsed);
        switch (parsed.id) {
            case "k":
                docker === null || docker === void 0 ? void 0 : docker.write(parsed.data.d);
                break;
            case "connect":
                const containerInfo = (_a = (0, child_process_1.execSync)(`docker ps -a -q -f name=${parsed.data.label}`)) === null || _a === void 0 ? void 0 : _a.toString("utf-8");
                console.log(containerInfo);
                if (docker) {
                }
                else if (containerInfo === null || containerInfo === void 0 ? void 0 : containerInfo.length) {
                    docker = (0, node_pty_1.spawn)("docker", ["start", "-ia", parsed.data.label], {
                        name: "computercraft",
                        cols: parsed.data.width,
                        rows: parsed.data.height,
                    });
                }
                else {
                    docker = (0, node_pty_1.spawn)("docker", ["run", "--name", parsed.data.label, "--entrypoint", "/bin/bash", "--hostname", parsed.data.label, "-it", "-e", "PS1='\\[\\][\\u@\\h \\W]\\$ \\[\\]'", parsed.data.image], {
                        name: "computercraft",
                        cols: parsed.data.width,
                        rows: parsed.data.height,
                    });
                }
                docker.onData((data) => {
                    const txData = Packet_1.PacketCrafter.writeToTerminal({ d: data });
                    // console.log(txData);
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
    socket.on("close", () => {
        docker === null || docker === void 0 ? void 0 : docker.kill();
        socket.close();
    });
});
