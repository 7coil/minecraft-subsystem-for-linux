const JASON = {
  stringify(data: any) {
    return textutils.serializeJSON(data);
  },
  parse(data: string) {
    const [parsedData, failureReason] = textutils.unserializeJSON(data);
    if (typeof failureReason === "string") throw new Error(`Tried to parse ${data}\z${failureReason}`);
    return parsedData;
  },
}
const log = (data: any) => print(JASON.stringify(data));

export { JASON, log }
