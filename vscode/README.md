# Lava

Volcanic-stone color themes by Pompei Tech: **Lava Dark** and **Lava Light**.

Warm lava orange on pumice and obsidian, with syntax colors tuned so every hue reaches at least WCAG AA contrast (4.5:1) on its background.

## Install

1. Open the Extensions view (`Cmd+Shift+X` / `Ctrl+Shift+X`) and search for **Lava**.
2. Install it, then run **Preferences: Color Theme** (`Cmd+K Cmd+T` / `Ctrl+K Ctrl+T`) and pick **Lava Dark** or **Lava Light**.

To follow the OS appearance automatically:

```jsonc
// settings.json
"window.autoDetectColorScheme": true,
"workbench.preferredDarkColorTheme": "Lava Dark",
"workbench.preferredLightColorTheme": "Lava Light"
```

## Palette

| Role | Light | Dark |
| --- | --- | --- |
| Lava (primary) | `#D65A31` | `#E86B3F` |
| Pomice (background) | `#FAF6EF` | `#0F0E0D` |
| Ossidiana (foreground) | `#2B211D` | `#F5EFE8` |
| Bronzo (highlight) | `#D8A146` | `#E0AA50` |
| Rosso pompeiano (error) | `#B9382B` | `#E05B52` |

## Other tools

Lava is also available for Neovim, tmux, WezTerm, iTerm2, kitty, Ghostty, Alacritty, lazygit, fzf and powerlevel10k. See the [main repository](https://github.com/pompeitech/pompeitech).

## License

[MIT](LICENSE)
