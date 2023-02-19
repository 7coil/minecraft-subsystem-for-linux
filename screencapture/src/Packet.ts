import { JASON } from "./JASON";

type Packet<ID extends string, T> = {
  id: ID,
  data: T,
}

type KeypressPacketData = {
  d: string;
}
type KeypressPacket = Packet<"k", KeypressPacketData>;


type TerminalWriteData = {
  d: string;
}
type TerminalWrite = Packet<"w", KeypressPacketData>;

type TerminalDebugData = {
  d: string;
}
type TerminalDebug = Packet<"debug", KeypressPacketData>;

type ConnectPacketData = {
  width: number;
  height: number;
  image: string;
}
type ConnectPacket = Packet<"connect", ConnectPacketData>;

type PacketTypes = KeypressPacket | TerminalWrite | ConnectPacket | TerminalDebug;

class PacketCrafter {
  static make<ID extends string, T>(id: ID, data: T): string {
    return JASON.stringify({
      id,
      data,
    })
  }

  static keypress(data: KeypressPacketData): string {
    return PacketCrafter.make("k", data)
  }

  static writeToTerminal(data: TerminalWriteData): string {
    return PacketCrafter.make("w", data);
  }

  static connect(data: ConnectPacketData): string {
    return PacketCrafter.make("connect", data);
  }

  static debug(data: TerminalDebugData): string {
    return PacketCrafter.make("debug", data);
  }
}

export { PacketCrafter }
export type { PacketTypes }
