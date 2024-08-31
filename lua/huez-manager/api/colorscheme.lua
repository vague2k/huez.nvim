local config = require("huez.config")
local utils = require("huez-manager.utils")
local M = {}

--- Reads and returns the persisted colorscheme as a `string` according to the "huez-colorscheme" file.
--- If reading failed, notify the user and return `nil`
---
---@param path? string
---@return string|nil
M.get = function(path)
  path = path or config.user.huez_colorscheme_file

  local file, _ = io.open(path, "r")

  if file == nil then
    utils.notify("Huez: could not read the huez_colorscheme file.", "error")
    return nil
  end

  local line = file:read()
  file:close()

  return line
end

--- Returns `string[]` where each item is the colorscheme name.
---
--- The array will contain all installed colorschemes if `Huez.Config.exclude` is an empty table
---
---@param exclude? string[]
---@return string[]
M.installed = function(exclude)
  exclude = exclude or config.user.exclude

  local colorschemes = vim.fn.getcompletion("", "color", true)
  local manually_installed = {}

  for _, colorscheme in pairs(colorschemes) do
    if not vim.tbl_contains(exclude, colorscheme) then
      table.insert(manually_installed, colorscheme)
    end
  end

  return manually_installed
end

--- Writes a colorscheme to the huez colorscheme file if the colorscheme is valid
--- and returns true if the file was written to successfully.
---
---@param colorscheme string
---@param path? string
---@return boolean
M.save = function(colorscheme, path)
  if not utils.colorscheme_exists(colorscheme) then
    local msg = string.format("Huez: could not find colorscheme '%s'", colorscheme)
    utils.notify(msg, "warn")
    return false
  end

  path = path or config.user.huez_colorscheme_file

  local file, _ = io.open(path, "w+")

  if file == nil then
    utils.notify("Huez: could not write to the huez_colorscheme file.", "error")
    return false
  end

  file:write(colorscheme)
  file:close()
  return true
end

return M
