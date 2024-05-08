local config = require("huez.config")
local registry = require("huez_manager.registry")

local M = {}

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

---@param type "favourites" | "live"
---@param theme string
---@return nil
M.remove_theme = function(type, theme)
  local path = config.current.path .. "/huez-" .. type .. "-themes"
  local file = io.open(path, "r")
  if file == nil then
    return
  end

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

  for _, line in ipairs(themes) do
    file:write(line .. "\n")
  end

  file:close()
end

return M
