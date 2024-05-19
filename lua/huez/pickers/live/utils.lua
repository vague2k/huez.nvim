local manager = require("huez_manager.selected")
local M = {}

---@param entry ThemeRegistryEntry
M.load_currently_installed = function(entry)
  if vim.tbl_contains(manager.live_themes, entry.pkgname) then
    vim.cmd.colorscheme(entry.colorscheme or entry.pkgname)
    return
  end

  vim.notify_once("Loading " .. entry.pkgname, nil, {
    hidden = vim.tbl_contains(manager.live_themes, entry.pkgname),
    ttl = 2,
  })

  manager.live_add(entry.pkgname)
  manager.lazy_flush()

  vim.cmd.colorscheme(entry.colorscheme or entry.pkgname)
end

return M
