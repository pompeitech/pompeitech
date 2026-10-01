local M = {}
local source = debug.getinfo(1, "S").source:sub(2)
local root = vim.fn.fnamemodify(source, ":p:h:h:h")
local theme_dir = root .. "/extras/lazygit/"
local config_dir

function M.apply(variant)
  if vim.fn.executable("lazygit") ~= 1 then
    return
  end
  local theme = theme_dir .. "lava-" .. variant .. ".yml"
  if vim.fn.filereadable(theme) ~= 1 then
    return
  end

  local files = {}
  for _, file in ipairs(vim.split(vim.env.LG_CONFIG_FILE or "", ",", { plain = true, trimempty = true })) do
    if file ~= theme_dir .. "lava-light.yml" and file ~= theme_dir .. "lava-dark.yml" then
      table.insert(files, file)
    end
  end
  if #files == 0 then
    if config_dir == nil then
      local result = vim.fn.system({ "lazygit", "--print-config-dir" })
      config_dir = vim.v.shell_error == 0 and vim.trim(result) or ""
    end
    local personal = config_dir .. "/config.yml"
    if config_dir ~= "" and vim.fn.filereadable(personal) == 1 then
      table.insert(files, personal)
    end
  end
  table.insert(files, theme)
  vim.env.LG_CONFIG_FILE = table.concat(files, ",")
end

return M
