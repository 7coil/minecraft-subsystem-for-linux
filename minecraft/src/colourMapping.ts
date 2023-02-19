const colourMapping = [
  [1, -1, 1],
  [39, -1, 1],
  [-1, 1, 32768],
  [-1, 49, 32768],
  [30, 40, 32768],
  [31, 41, 64],
  [32, 42, 8192],
  [33, 43, 2],
  [34, 44, 8],
  [35, 45, 1024],
  [36, 46, 512],
  [37, 47, 1],
  [90, 100, 128],
  [91, 101, 16384],
  [92, 102, 32],
  [93, 103, 16],
  [94, 104, 2048],
  [95, 105, 4],
];

const findForeground = (ansi: number): number | undefined => {
  const found = colourMapping.find(([foreground, background, computercraft]) => foreground === ansi);
  if (found) return found[2] >= 0 ? found[2] : undefined
  return undefined
}

const findBackground = (ansi: number): number | undefined => {
  const found = colourMapping.find(([foreground, background, computercraft]) => background === ansi);
  if (found) return found[2] >= 0 ? found[2] : undefined
  return undefined
}

export { findBackground, findForeground }
