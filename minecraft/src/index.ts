import { BufferlessFrame } from "./BufferlessFrame";
import { getCharacter } from "./getCharacter";
import { JASON } from "./JASON";
import { PacketCrafter, PacketTypes } from "./Packet";
import { TerminalParser } from "./TerminalParser";

const main = (args: string[]) => {
  if (args.length === 1 && args[0] === "index") return;

  const image = args[0] ?? "ubuntu";
  const label = `msl-${image.replaceAll(":", "-")}-${os.computerID()}`

  // Start off by connecting to Salesforce
  const [websocket, failureReason] = http.websocket("ws://localhost:8080");
  
  if (!websocket) {
    printError(`Failed to connect to Docker!`);
    printError(failureReason);
  } else {
    const framebuffer = new BufferlessFrame(websocket);
    const terminalParser = new TerminalParser(framebuffer);

    let running = true;
    let leftShift = false;
    let rightShift = false;
    let leftCtrl = false;
    let rightCtrl = false;

    const [terminalWidth, terminalHeight] = term.getSize();
    websocket.send(
      PacketCrafter.connect({
        width: terminalWidth,
        height: terminalHeight,
        image,
        label,
      })
    );

    while (running) {
      const unknownEvent = os.pullEvent();

      if (unknownEvent[0] === "websocket_message") {
        const [, , message] =
          unknownEvent as LuaMultiReturn<os.Events.WebsocketMessageEvent>;

        const parsed = JASON.parse(message) as PacketTypes;

        switch (parsed.id) {
          case "w":
            terminalParser.parse(parsed.data.d);
            framebuffer.complete();
            break;
        }
      }

      if (unknownEvent[0] === "key") {
        const [, key, hold] =
          unknownEvent as LuaMultiReturn<os.Events.KeyEvent>;
        const keyName = keys.getName(key);

        switch (keyName) {
          case null:
            break;
          case "leftShift":
            leftShift = true;
            break;
          case "rightShift":
            rightShift = true;
            break;
          case "leftCtrl":
            leftCtrl = true;
            break;
          case "rightCtrl":
            rightCtrl = true;
            break;
          default:
            const characterToSend = getCharacter(
              keyName,
              leftShift || rightShift,
              leftCtrl || rightCtrl
            );
            if (characterToSend)
              websocket.send(PacketCrafter.keypress({ d: characterToSend }));
        }
      }

      if (unknownEvent[0] === "key_up") {
        const [, key] = unknownEvent as LuaMultiReturn<os.Events.KeyUpEvent>;

        const keyName = keys.getName(key);

        switch (keyName) {
          case null:
            break;
          case "leftShift":
            leftShift = false;
            break;
          case "rightShift":
            rightShift = false;
            break;
          case "leftCtrl":
            leftCtrl = false;
            break;
          case "rightCtrl":
            rightCtrl = false;
            break;
        }
      }

      if (unknownEvent[0] === "websocket_closed") {
        framebuffer.destroy();
        running = false;
        print("Websocket closed.");
      }
    }
  }
};

main([...$vararg]);
