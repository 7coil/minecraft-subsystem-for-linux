const JSON = {
  stringify(data: any) {
    return textutils.serializeJSON(data, false);
  },
  parse(data: string) {
    return textutils.unserializeJSON(data);
  },
}

export { JSON }
