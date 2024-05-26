local log = require("huez-manager.utils.log")
local config = require("huez.config")
local M = {}

--- Reads and returns the persisted colorscheme as a `string` according to {path} or "huez-theme" file.
---
--- If reading failed, returns `nil`
---
---@param path? string
---@return string|nil
M.get = function(path)
  path = path or config.current.huez_theme_file

  local file, err = io.open(path, "r")

  if file == nil then
    return nil, log.notify("From colorscheme.get() - Error reading file: \n" .. err, "error")
  end

  local line = file:read()
  file:close()

  return line
end

--- Returns string[] where each item is the theme name.
---
--- The array will contain all installed themes if {exclude} is {}
---
---@param exclude? string[]
---@return string[]
M.installed = function(exclude)
  exclude = exclude or config.current.exclude

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

--- Writes colorscheme to {path}, returns true if write was successful, false otherwise
---
---@param colorscheme string
---@param path? string
---@return boolean
M.save = function(colorscheme, path)
  path = path or config.current.huez_theme_file

  local file, err = io.open(path, "w+")

  if file == nil then
    return false, log.notify("From colorscheme.save() - Error writing to file: \n" .. err, "error")
  end

  file:write(colorscheme)
  file:close()
  return true
end

return M
