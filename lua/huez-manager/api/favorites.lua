local config = require("huez.config")
local log = require("huez-manager.utils.log")

local M = {}

M.file = config.current.path .. "/huez-favorite-themes"

--- Returns a `string[]` of themes that are favorited
---
---@param path? string
---@return string[]
M.list = function(path)
  path = path or M.file
  local file = io.open(path, "r")
  if file == nil then
    return {}
  end

  local favorited_themes = {}
  for line in file:lines() do
    table.insert(favorited_themes, line)
  end

  file:close()

  return favorited_themes
end

--- Add a theme to the `huez-favorite-themes` file, marking it as favorited
--- If addition was successful, returns true, otherwise returns false
---
---@param theme string
---@param path? string
---@return boolean
M.add = function(theme, path)
  path = path or M.file
  local favorites = M.list()

  -- if theme is already marked as favorite return
  if vim.tbl_contains(favorites, theme) then
    log.notify("The theme, '" .. theme .. "' is already marked as favorited", "error")
    return false
  end

  local file = io.open(path, "a")
  if file == nil then
    return false
  end

  file:write(theme .. "\n")
  file:close()
  return true
end

--- Remove a theme to the `huez-favorite-themes` file, unmarking it as favorited
--- If removal was successful, returns true, otherwise returns false
---
---@param theme string
---@param path? string
M.remove = function(theme, path)
  path = path or M.file

  local file = io.open(path, "r")
  if file == nil then
    return false
  end

  -- create a new array of the {type} file lines excluding where line == {theme}
  local themes = {}
  for line in file:lines() do
    if line ~= theme then
      table.insert(themes, line)
    end
  end

  file:close()

  file = io.open(path, "w")
  if file == nil then
    return false
  end

  -- rewrite the {type} file with the `themes` table and excluding {theme}
  for _, line in ipairs(themes) do
    file:write(line .. "\n")
  end

  file:close()
  return true
end

return M
