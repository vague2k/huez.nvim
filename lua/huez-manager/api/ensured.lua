local api_utils = require("huez-manager.utils.api_utils")

local M = {}

---@type InstalledThemes
M.installed = api_utils.load_themes("ensured")

--- Adds a theme to the `huez-favourites-themes` file.
---
---@param theme string
---@return nil
M.add = function(theme)
  -- vim.notify("Adding " .. theme .. " to favourites")
  api_utils.add_theme("ensured", theme)
  M.installed = api_utils.load_themes("ensured")
end

--- Removes a theme from the `huez-favourites-themes` file.
---
---@param theme string
---@return nil
M.remove = function(theme)
  api_utils.remove_theme("ensured", theme)
  M.installed = api_utils.load_themes("ensured")
end

return M
