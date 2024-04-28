local utils = require("huez.utils")
local config = require("huez.config")
local api = {}

--- Gets the persisted colorscheme according to "huez-theme" file.
---
---@param path? string
---@return string|nil
api.get_colorscheme = function(path)
  if path == nil then
    path = config.current.file_path
  end

  local file, err = io.open(path, "r")

  if not file then
    return nil, utils.log_error("api.get_colorscheme - Error reading file: \n" .. err)
  end

  local line = file:read()
  file:close()

  return line
end

--- Returns an array of strings where each item is the theme name.
---
--- The array will contain all installed themes if {exclude} is nil or {}
---
---@param exclude? string[]
---@return string[]
api.get_installed_themes = function(exclude)
  if exclude == nil then
    exclude = exclude or config.current.exclude
  end

  local themes = vim.fn.getcompletion("", "color", true)
  local manually_installed = {}

  ---@type string
  for _, theme in pairs(themes) do
    if not vim.tbl_contains(exclude, theme) then
      table.insert(manually_installed, theme)
    end
  end

  return manually_installed
end

--- Writes colorscheme to {path}, returns true if write was successful, nil otherwise
---
---@param colorscheme string
---@param path? string
---@return boolean|nil
api.save_colorscheme = function(colorscheme, path)
  if path == nil then
    path = config.current.file_path
  end

  local file, err = io.open(path, "w+")

  if not file then
    return nil, utils.log_error("api.save_colorscheme - Error writing to file: \n" .. err)
  end

  file:write(colorscheme)
  file:close()
  return true
end

return api
