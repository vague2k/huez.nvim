local config = require("huez.config")
local registry = require("huez_manager.manage.registry")

local M = {}

--- Returns a `string[]` of themes if they are found in a `huez-favourites/live-themes` file or a custom path, and if they are found within
--- the registry.
---
---@param type "favourites" | "live"
---@param path? string
---@return InstalledThemes
M.load_themes = function(type, path)
  path = path or config.current.path .. "/huez-" .. type .. "-themes"

  local file = io.open(path, "r")
  if file == nil then
    return {}
  end

  local themes = {}
  for line in file:lines() do
    if registry[line] then
      table.insert(themes, line)
    else
      vim.notify("Theme " .. line .. " not found in registry")
    end
  end

  file:close()

  return themes
end

--- Adds a theme to the `huez-favourites/live-themes` file by appending a new line (being the theme).
---
---@param type "favourites" | "live"
---@param theme string
---@return nil
M.add_theme = function(type, theme)
  if not registry[theme] then
    vim.notify("Theme " .. theme .. " not found in registry")
    return
  end

  local existing = M.load_themes(type)
  if vim.tbl_contains(existing, theme) then
    vim.notify("Theme " .. theme .. " already exists in " .. type)
    return
  end

  local path = config.current.path .. "/huez-" .. type .. "-themes"
  local file = io.open(path, "a")
  if file == nil then
    return
  end

  file:write(theme .. "\n")
  file:close()
end

--- Removes a theme from the `huez-favourites/live-themes` file by rewriting the file excluding {theme}.
---
---@param type "favourites" | "live"
---@param theme string
---@return nil
M.remove_theme = function(type, theme)
  local path = config.current.path .. "/huez-" .. type .. "-themes"
  local file = io.open(path, "r")
  if file == nil then
    return
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
    return
  end

  -- rewrite the {type} file with the `themes` table and excluding {theme}
  for _, line in ipairs(themes) do
    file:write(line .. "\n")
  end

  file:close()
end

return M
