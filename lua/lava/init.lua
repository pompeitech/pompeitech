local M = {}

---@class LavaConfig
---@field style "dark"|"light"|nil  force a variant; nil follows vim.o.background
---@field transparent boolean  don't set a background color
---@field italic_comments boolean
---@field on_colors fun(colors: table)|nil  tweak the palette before highlights are built
---@field on_highlights fun(hl: table, colors: table)|nil  override individual highlight groups
M.config = {
  style = nil,
  transparent = false,
  italic_comments = true,
  on_colors = nil,
  on_highlights = nil,
}

---@param opts LavaConfig|nil
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

---@param variant "dark"|"light"|nil
function M.load(variant)
  local name = variant and "lava-" .. variant or "lava"
  variant = variant or M.config.style or vim.o.background
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  vim.o.termguicolors = true
  vim.o.background = variant
  vim.g.colors_name = name

  local colors = vim.deepcopy(require("lava.palettes." .. variant))
  if M.config.on_colors then
    M.config.on_colors(colors)
  end

  local hl = require("lava.highlights").get(colors, M.config)
  if M.config.on_highlights then
    M.config.on_highlights(hl, colors)
  end

  for group, spec in pairs(hl) do
    vim.api.nvim_set_hl(0, group, spec)
  end

  local t = colors.terminal
  local ansi = {
    t.black, t.red, t.green, t.yellow, t.blue, t.magenta, t.cyan, t.white,
    t.bright_black, t.bright_red, t.bright_green, t.bright_yellow,
    t.bright_blue, t.bright_magenta, t.bright_cyan, t.bright_white,
  }
  for i, c in ipairs(ansi) do
    vim.g["terminal_color_" .. (i - 1)] = c
  end
end

return M
