local api = require("huez-manager.api")
local selected = require("huez-manager.api.selected")
local log = require("huez-manager.utils.log")
local conf = require("huez.config")
local M = {}

---@param entry ThemeRegistryEntry
M.load_currently_installed = function(entry)
  log.notify_once("Loading " .. entry.pkgname, "info", {
    hidden = vim.tbl_contains(api.live.installed, entry.pkgname),
    ttl = 2,
  })
  api.live.add(entry.pkgname)
  selected.lazy_flush()

  conf.set_theme(entry.colorscheme or entry.pkgname)
end

return M
