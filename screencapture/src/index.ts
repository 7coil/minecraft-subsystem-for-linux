import { execSync, spawnSync } from "child_process";
import { IPty, spawn } from "node-pty";
import { WebSocketServer } from "ws";
import { PacketCrafter, PacketTypes } from "./Packet";

const webSocketServer = new WebSocketServer({
  port: 8080,
});

webSocketServer.on("connection", (socket) => {
  let docker: IPty | null = null;

  socket.on("message", (data: any) => {
    const parsed = JSON.parse(data) as PacketTypes;

    console.log(parsed);
    
    switch(parsed.id) {
      case "k":
        docker?.write(parsed.data.d);
        break;
      case "connect":
        const containerInfo = execSync(`docker ps -a -q -f name=${parsed.data.label}`)?.toString("utf-8");
        console.log(containerInfo);

        if (docker) {
          
        } else if (containerInfo?.length) {
          docker = spawn("docker", ["start", "-ia", parsed.data.label], {
            name: "computercraft",
            cols: parsed.data.width,
            rows: parsed.data.height,
          });
        } else {
          docker = spawn("docker", ["run", "--name", parsed.data.label, "--entrypoint", "/bin/bash", "--hostname", parsed.data.label, "-i", parsed.data.image], {
            name: "computercraft",
            cols: parsed.data.width,
            rows: parsed.data.height,
          });
        }
      
        docker.onData((data: string) => {
          const txData = PacketCrafter.writeToTerminal({ d: data });
          // console.log(txData);
          socket.send(txData);
        });

        docker.onExit(() => {
          socket.close();
        })
        break;
    }
  })

  socket.on("error", () => {
    docker?.kill();
    socket.close();
  });

  socket.on("close", () => {
    docker?.kill();
    socket.close();
  });
});
