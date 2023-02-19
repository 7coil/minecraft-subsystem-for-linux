import { IPty, spawn } from "node-pty";
import { WebSocketServer } from "ws";
import { PacketCrafter, PacketTypes } from "./Packet";

const webSocketServer = new WebSocketServer({
  port: 8080,
});

webSocketServer.on("connection", (socket) => {
  let docker: IPty | null = null;

  socket.on("close", () => {
    docker?.kill();
  });

  socket.on("message", (data: any) => {
    const parsed = JSON.parse(data) as PacketTypes;

    console.log(parsed);
    
    switch(parsed.id) {
      case "k":
        docker?.write(parsed.data.d);
        break;
      case "connect":
        docker = spawn("docker", ["run", "-it", parsed.data.image, "/bin/bash"], {
          name: "computercraft",
          cols: parsed.data.width,
          rows: parsed.data.height,
        });
      
        docker.onData((data: string) => {
          const txData = PacketCrafter.writeToTerminal({ d: data });
          console.log(txData);
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
});
