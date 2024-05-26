local loader = require("lazy.core.loader")
local lazy = require("lazy")
local plugins = require("lazy.core.plugin")

local registry = require("huez-manager.registry")
local api = require("huez-manager.api")

local M = {}

---@alias InstalledThemes string[]
---@return InstalledThemes
M.selected = function()
  return vim.tbl_extend("force", api.ensured.installed, api.live.installed)
end

--- "Flushs" any themes that were added or removed INTO lazy, or OUT of lazy, according to the
--- `huez-favorites/live-themes` files.
---
--- This function acts as a sort of "self-cleaning" approach, when doing live previews and ensures themes marked as
--- favorite are always installed.
---@param plugins_list? InstalledThemes
---@return nil
M.lazy_flush = function(plugins_list)
  loader.reload("huez.nvim")
  plugins_list = plugins_list or M.selected()

  local pkgList = {}
  local installed = api.colorscheme.installed()
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

  plugins.load()
  vim.api.nvim_exec_autocmds("User", { pattern = "LazyReload", modeline = false })
  lazy.install({ show = false, plugins = pkgList, wait = true }) ---@diagnostic disable-line
  lazy.load({ show = false, plugins = pkgList })
  loader.reload("huez.nvim")
end

return M
