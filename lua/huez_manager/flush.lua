local loader = require("lazy.core.loader")
local lazy = require("lazy")
local plugins = require("lazy.core.plugin")
local registry = require("huez_manager.registry")
local installed = require("huez.api.colorscheme").installed()
local M = {}

---@param plugins_list? InstalledThemes
---@return nil
M.lazy_flush = function(plugins_list)
  loader.reload("huez.nvim")
  plugins_list = plugins_list or require("huez_manager.selected").selected()
  local pkgList = {}
  for _, value in ipairs(plugins_list) do
    if not vim.tbl_contains(installed, value) then
      table.insert(pkgList, registry[value].pkgname)
    end
  end
  if #pkgList == 0 then
    -- No plugins to flush
    -- Anything that is temporary will be flushed on next nvim restart
    return
  end
  vim.notify("Flushing plugins" .. vim.inspect(pkgList))
  plugins.load()
  vim.api.nvim_exec_autocmds("User", { pattern = "LazyReload", modeline = false })
  pcall(lazy.install({ show = false, plugins = pkgList, wait = true }))
  lazy.load({ show = false, plugins = pkgList })
  loader.reload("huez.nvim")
end

-- -- FIXME: this extra reload is a workaround until we implement
-- -- file reading to get the selected themes
-- M.lazy_flush(require("huez_manager.selected").selected())

return M
