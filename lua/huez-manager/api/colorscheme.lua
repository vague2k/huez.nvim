local config = require("huez.config")
local M = {}

--- Reads and returns the persisted colorscheme as a `string` according to {path} or "huez-colorscheme" file.
---
--- If reading failed, returns `nil`
---
---@param path? string
---@return string|nil
M.get = function(path)
  path = path or config.user.huez_colorscheme_file

  local file, _ = io.open(path, "r")

  if file == nil then
    return nil
  end

  local line = file:read()
  file:close()

  return line
end

--- Returns string[] where each item is the colorscheme name.
---
--- The array will contain all installed colorschemes if {exclude} is {}
---
---@param exclude? string[]
---@return string[]
M.installed = function(exclude)
  exclude = exclude or config.user.exclude

  local colorschemes = vim.fn.getcompletion("", "color", true)
  local manually_installed = {}

  ---@type string
  for _, colorscheme in pairs(colorschemes) do
    if not vim.tbl_contains(exclude, colorscheme) then
      table.insert(manually_installed, colorscheme)
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
  path = path or config.user.huez_colorscheme_file

  local file, _ = io.open(path, "w+")

  if file == nil then
    return false
  end

  file:write(colorscheme)
  file:close()
  return true
end

return M
