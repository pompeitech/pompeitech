// Maps the brand spec (palette/*.json) onto the flat color set every port uses.
// Brand tokens are used verbatim; everything else is derived from them here.

import { toHex, mix, lighten } from "./color.mjs";

const resolve = (obj) => Object.fromEntries(Object.entries(obj).map(([k, v]) => [k, toHex(v)]));

export function derive(variant, raw) {
  const s = resolve(raw.spec);
  const x = resolve(raw.syntax);
  const dark = variant === "dark";

  const colors = {
    // surfaces
    bg: s.background,
    bg_dark: mix(s.background, s.secondary, 0.35), // statusline, tabline, sidebars
    bg_float: s.card,
    bg_highlight: mix(s.background, s.secondary, 0.45), // cursorline
    bg_visual: s.accent,
    border: s.border,

    // text
    fg: s.foreground,
    fg_dark: mix(s.foreground, s.muted_foreground, 0.5),
    comment: dark ? mix(s.muted_foreground, s.background, 0.2) : s.muted_foreground,
    dark3: mix(s.border, s.muted_foreground, 0.6),
    fg_gutter: mix(s.border, s.muted_foreground, 0.35),

    // brand accents (UI)
    primary: s.primary,
    on_primary: s.primary_foreground,
    highlight: s.highlight,
    on_highlight: s.highlight_foreground,

    // syntax
    ...x,

    // semantic
    error: s.destructive,
    warning: x.yellow,
    info: x.blue,
    hint: x.teal,
    git_add: x.green,
    git_change: x.yellow,
    git_delete: s.destructive,
  };

  const tint = dark ? 0.16 : 0.22;
  colors.diff_add = mix(s.background, x.green, tint);
  colors.diff_change = mix(s.background, x.yellow, tint);
  colors.diff_delete = mix(s.background, s.destructive, tint);
  colors.diff_text = mix(s.background, x.yellow, tint * 2);

  const base = { red: s.destructive, green: x.green, yellow: x.yellow, blue: x.blue, magenta: x.magenta, cyan: x.teal };
  const bright = (c) => lighten(c, dark ? 0.08 : -0.07);
  const terminal = {
    black: dark ? s.secondary : s.foreground,
    ...base,
    white: dark ? s.muted_foreground : s.border,
    bright_black: dark ? mix(s.border, s.muted_foreground, 0.5) : s.muted_foreground,
    ...Object.fromEntries(Object.entries(base).map(([k, v]) => [`bright_${k}`, bright(v)])),
    bright_white: dark ? s.foreground : s.secondary,
  };
  // keep ANSI order stable: black, red, ..., white, bright_black, ...
  const order = ["black", "red", "green", "yellow", "blue", "magenta", "cyan", "white"];
  const ordered = Object.fromEntries([...order, ...order.map((k) => `bright_${k}`)].map((k) => [k, terminal[k]]));

  return { colors, terminal: ordered };
}
