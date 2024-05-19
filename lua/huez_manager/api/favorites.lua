local api_utils = require("huez_manager.utils.api_utils")

local M = {}

---@type InstalledThemes
M.installed = api_utils.load_themes("favourites")

--- Adds a theme to the `huez-favourites-themes` file.
---
---@param theme string
---@return nil
M.add = function(theme)
  -- vim.notify("Adding " .. theme .. " to favourites")
  api_utils.add_theme("favourites", theme)
  M.favourites = api_utils.load_themes("favourites")
end

--- Removes a theme from the `huez-favourites-themes` file.
---
---@param theme string
---@return nil
M.remove = function(theme)
  api_utils.remove_theme("favourites", theme)
  M.favourites = api_utils.load_themes("favourites")
end

return M
