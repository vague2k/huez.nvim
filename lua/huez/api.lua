local config = vim.g.huez_config
local persist = require("huez.persist")
local utils = require("huez.utils")
local api = {}

---@return string
-- gets the persisted colorscheme according to .huez.nvim.lua file, or vim.g.huez_colorscheme
api.get_colorscheme = function()
  local file, err = io.open(config.file_path, "r")

  if not file then
    return "", utils.log_error("Huez: Error reading file: " .. err)
  end

  local line = file:read()
  file:close()

  return line
end

---@return table
-- Returns an array of all themes, except any omitted themes according to the Huez config
api.filter_default_themes = function()
  local default_themes = vim.g.huez_config.omit
  local all_installed_themes = vim.fn.getcompletion("", "color", true)

  local default_omitted = {}

  for _, themes in ipairs(all_installed_themes) do
    if not vim.tbl_contains(default_themes, themes) then
      table.insert(default_omitted, themes)
    end
  end

  return default_omitted
end

---@param colorscheme string
-- saves colorscheme to the file specific in the config's file_path
api.save_colorscheme = function(colorscheme)
  vim.cmd("hi clear")
  vim.cmd("syntax reset")
  vim.cmd("colorscheme " .. colorscheme)
  persist._write_theme_to_file(colorscheme)
end

return api
