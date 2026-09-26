# Pompei Tech — Lava

The Pompei Tech color themes, forged from volcanic stone: **Lava Dark** and **Lava Light**, ported to every tool we use.

| Tool | Location |
| --- | --- |
| Neovim | repository root (`colors/`, `lua/lava/`) |
| VS Code | [`vscode/`](vscode) |
| WezTerm | [`extras/wezterm`](extras/wezterm) |
| tmux | TPM plugin (`lava.tmux` at the root) |
| lualine | ships with the Neovim plugin (`theme = "lava"`) |
| lazygit | [`extras/lazygit`](extras/lazygit) |
| iTerm2 | [`extras/iterm`](extras/iterm) |
| fzf | [`extras/fzf`](extras/fzf) (also applied to tmux popups by the tmux plugin) |
| powerlevel10k | [`extras/p10k`](extras/p10k) |
| kitty | [`extras/kitty`](extras/kitty) |
| Ghostty | [`extras/ghostty`](extras/ghostty) |
| Alacritty | [`extras/alacritty`](extras/alacritty) |

## Palette

The single source of truth is [`palette/lava.json`](palette/lava.json). It mirrors the brand spec:

| Role | Name | Light | Dark |
| --- | --- | --- | --- |
| Primary | Lava | `#D65A31` | `#E86B3F` |
| Background | Pomice | `#FAF6EF` | `#0F0E0D` |
| Foreground | Ossidiana | `#2B211D` | `#F5EFE8` |
| Card | Marmo caldo | `#FFFDF9` | `#181513` |
| Secondary | Cenere chiara | `#EDE4D8` | `#28221E` |
| Accent | Terracotta tenue | `#F3D5BF` | `#3A2016` |
| Muted text | Cenere | `#756860` | `#A99D94` |
| Border | Pietra | `#DDD1C4` | `#3A302A` |
| Destructive | Rosso pompeiano | `#B9382B` | `#E05B52` |
| Highlight | Bronzo | `#D8A146` | `#E0AA50` |

The `syntax` block adds the extra hues a code editor needs (olive, fresco teal, sky blue, rose…). They are defined in OKLCH at the same warmth as the brand colors, and every one of them reaches at least WCAG AA contrast (4.5:1) on its background. The light variant uses the spec's `primary-emphasis` for keywords and a darker bronze for types, because the bright UI tones are too light to read as text on Pomice.

## Neovim

```lua
-- lazy.nvim
{
  "pompeitech/pompeitech", -- adjust to the real repo path
  lazy = false,
  priority = 1000,
  opts = {
    -- style = "dark",        -- "dark" | "light" | nil (nil follows vim.o.background)
    -- transparent = false,
    -- italic_comments = true,
    -- on_colors = function(colors) end,
    -- on_highlights = function(hl, colors) end,
  },
  config = function(_, opts)
    require("lava").setup(opts)
    vim.cmd.colorscheme("lava")
  end,
}
```

Colorschemes: `lava` (follows `background` / `style`), `lava-dark`, `lava-light`.

Integrated plugins: lualine (`theme = "lava"`, `"lava-dark"`, `"lava-light"`), barbecue/navic (`theme = "auto"`), neo-tree, noice, snacks, trouble, telescope, blink.cmp, which-key, gitsigns, todo-comments, rainbow-delimiters, lazy.nvim, mason, octo.nvim, copilot, yanky.

## VS Code

```sh
cd vscode && npx @vscode/vsce package   # produces lava-theme-<version>.vsix
code --install-extension lava-theme-*.vsix
```

For local development, open `vscode/` in VS Code and press F5.

## WezTerm

```lua
config.color_scheme_dirs = { "/path/to/pompeitech/extras/wezterm" }
config.color_scheme = "Lava Dark"
```

## tmux

With [TPM](https://github.com/tmux-plugins/tpm):

```tmux
set -g @plugin 'pompeitech/pompeitech'
set -g @lava_style 'dark'   # or 'light'
```

Then press `prefix + I`. Without TPM: `source-file /path/to/pompeitech/extras/tmux/lava-dark.tmux`.

The theme also colors every popup (`popup-style`, `popup-border-style`) and sets defaults for these plugins. Each value is applied only if you haven't set it yourself:

| Plugin | Options set |
| --- | --- |
| [tmux-floax](https://github.com/omerxx/tmux-floax) | `@floax-border-color`, `@floax-text-color` |
| [tmux-sessionx](https://github.com/omerxx/tmux-sessionx) | `@sessionx-additional-options` (fzf colors) |
| [tmux-prefix-highlight](https://github.com/tmux-plugins/tmux-prefix-highlight) | `@prefix_highlight_fg`, `@prefix_highlight_bg` |

Declare `@plugin 'pompeitech/pompeitech'` **before** those plugins so they pick the colors up when they load. floax is refreshed anyway if it loads first.

## lazygit

lazygit merges multiple config files, so keep your own config and add the theme on top:

```sh
export LG_CONFIG_FILE="$HOME/Library/Application Support/lazygit/config.yml,/path/to/pompeitech/extras/lazygit/lava-dark.yml"
```

With `lazygit.nvim`:

```lua
vim.g.lazygit_use_custom_config_file_path = 1
vim.g.lazygit_config_file_path = {
  vim.fn.expand("~/Library/Application Support/lazygit/config.yml"), -- your own config (macOS default path)
  vim.fn.stdpath("data") .. "/lazy/pompeitech/extras/lazygit/lava-dark.yml",
}
```

## Shell (zsh)

```zsh
export LAVA_STYLE="dark"                           # or "light"
export LAVA_HOME="$HOME/.local/share/nvim/lazy/lava" # any clone of this repo
source $LAVA_HOME/extras/fzf/lava-$LAVA_STYLE.sh     # fzf colors (idempotent)
source $LAVA_HOME/extras/p10k/lava-$LAVA_STYLE.zsh   # after ~/.p10k.zsh
```

powerlevel10k's lean style hardcodes the git colors inside `my_git_formatter`. To let Lava color them, change those four lines in `~/.p10k.zsh` so they read the Lava variables and keep the originals as fallback:

```zsh
local      clean=${LAVA_GIT_CLEAN:-'%76F'}
local   modified=${LAVA_GIT_MODIFIED:-'%178F'}
local  untracked=${LAVA_GIT_UNTRACKED:-'%39F'}
local conflicted=${LAVA_GIT_CONFLICTED:-'%196F'}
```

## iTerm2

Settings → Profiles → Colors → Color Presets… → Import… → `extras/iterm/lava-dark.itermcolors`, then select it from the same menu.

## kitty · Ghostty · Alacritty

```conf
# kitty.conf
include /path/to/pompeitech/extras/kitty/lava-dark.conf
```

```conf
# ghostty config (or copy the file into ~/.config/ghostty/themes/)
theme = /path/to/pompeitech/extras/ghostty/lava-dark
```

```toml
# alacritty.toml
[general]
import = ["/path/to/pompeitech/extras/alacritty/lava-dark.toml"]
```

## Development

Everything under `extras/`, `vscode/themes/` and `lua/lava/palettes/` is **generated**. Don't edit those files by hand:

```sh
# edit palette/lava.json (or scripts/derive.mjs for the spec → editor mapping), then
npm run build
```

- `scripts/color.mjs`: OKLCH ↔ sRGB conversions (CSS Color 4) and contrast helpers
- `scripts/derive.mjs`: maps the brand tokens onto the flat color set the ports use
- `scripts/build.mjs`: one template per target; add a new tool by adding an entry to `targets`

Neovim highlight groups are hand-written in `lua/lava/highlights.lua`.
