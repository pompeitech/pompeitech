-- Builds a lualine theme from a Lava palette. Exposed to lualine through
-- lua/lualine/themes/lava*.lua, so `theme = "lava"` just works.
return function(variant)
  variant = variant or (vim.g.colors_name == "lava-light" and "light")
    or (vim.g.colors_name == "lava-dark" and "dark")
    or vim.o.background
  local c = require("lava.palettes." .. variant)

  local function mode(accent, fg)
    return {
      a = { bg = accent, fg = fg, gui = "bold" },
      b = { bg = c.bg_highlight, fg = accent },
      c = { bg = c.bg_dark, fg = c.fg_dark },
    }
  end

  return {
    normal = mode(c.primary, c.on_primary),
    insert = mode(c.green, c.bg),
    visual = mode(c.highlight, c.on_highlight),
    replace = mode(c.red, c.on_primary),
    command = mode(c.magenta, c.bg),
    terminal = mode(c.teal, c.bg),
    inactive = {
      a = { bg = c.bg_dark, fg = c.dark3 },
      b = { bg = c.bg_dark, fg = c.dark3 },
      c = { bg = c.bg_dark, fg = c.dark3 },
    },
  }
end
