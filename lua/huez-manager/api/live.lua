local api_utils = require("huez-manager.utils.api_utils")

local M = {}

---@type InstalledThemes
M.installed = api_utils.load_themes("live")

--- Adds a theme to the `huez-live-themes` file.
---
---@param theme string
---@return nil
M.add = function(theme)
  api_utils.add_theme("live", theme)
  M.installed = api_utils.load_themes("live")
end

--- Removes a theme from the `huez-live-themes` file.
---
---@param theme string
---@return nil
M.remove = function(theme)
  api_utils.remove_theme("live", theme)
  M.installed = api_utils.load_themes("live")
end

return M
