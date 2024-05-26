local api = require("huez-manager.api")
local selected = require("huez-manager.api.selected")
local M = {}

---@param entry ThemeRegistryEntry
M.load_currently_installed = function(entry)
  vim.notify_once("Loading " .. entry.pkgname, nil, {
    title = "Huez.nvim",
    hidden = vim.tbl_contains(api.live.installed, entry.pkgname),
    ttl = 2,
  })

  api.live.add(entry.pkgname)
  selected.lazy_flush()

  vim.cmd.colorscheme(entry.colorscheme or entry.pkgname)
end

return M
