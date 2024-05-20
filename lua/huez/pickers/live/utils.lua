local api = require("huez-manager.api.init")
local selected = require("huez-manager.api.selected")
local M = {}

---@param entry ThemeRegistryEntry
M.load_currently_installed = function(entry)
  if vim.tbl_contains(api.live.installed, entry.pkgname) then
    vim.cmd.colorscheme(entry.colorscheme or entry.pkgname)
    return
  end

  vim.notify_once("Loading " .. entry.pkgname, nil, {
    hidden = vim.tbl_contains(api.live.installed, entry.pkgname),
    ttl = 2,
  })

  api.live.add(entry.pkgname)
  selected.lazy_flush()

  vim.cmd.colorscheme(entry.colorscheme or entry.pkgname)
end

return M
