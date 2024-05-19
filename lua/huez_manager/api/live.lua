local api_utils = require("huez_manager.utils")

local M = {}

---@type InstalledThemes
M.installed = api_utils.load_themes("live")

--- Adds a theme to the `huez-live-themes` file.
---
---@param theme string
---@return nil
M.add = function(theme)
  -- vim.notify("Adding " .. theme .. " to live themes")
  api_utils.add_theme("live", theme)
  M.live_themes = api_utils.load_themes("live")
end

--- Removes a theme from the `huez-live-themes` file.
---
---@param theme string
---@return nil
M.remove = function(theme)
  api_utils.remove_theme("live", theme)
  M.live_themes = api_utils.load_themes("live")
end

return M
