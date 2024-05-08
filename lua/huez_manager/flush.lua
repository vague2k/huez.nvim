local loader = require("lazy.core.loader")
local lazy = require("lazy")
local plugins = require("lazy.core.plugin")
local registry = require("huez_manager.registry")
local installed = require("huez.api.colorscheme").installed()
local M = {}

--- "Flushs" any themes that were added or removed INTO lazy, or OUT of lazy, according to the `huez-favorites/live-themes` files.
---
--- This function acts as a sort of "self-cleaning" approach, when doing live previews and ensures themes marked as favorite are always installed.
---@param plugins_list? InstalledThemes
---@return nil
M.lazy_flush = function(plugins_list)
  -- first, reload huez for a fresh state
  loader.reload("huez.nvim")

  plugins_list = plugins_list or require("huez_manager.selected").selected()
  local pkgList = {}

  -- if a theme is not currently installed add it to the pkgList
  for _, theme in ipairs(plugins_list) do
    if not vim.tbl_contains(installed, theme) then
      table.insert(pkgList, registry[theme].pkgname)
    end
  end
  if #pkgList == 0 then
    -- No plugins to flush
    -- Anything that is temporary will be flushed on next nvim restart
    return
  end

  vim.notify("Flushing plugins" .. vim.inspect(pkgList))
  plugins.load()

  vim.api.nvim_exec_autocmds("User", {
    pattern = "LazyReload",
    modeline = false,
  })

  lazy.install({
    show = false,
    plugins = pkgList,
    wait = true,
  })

  lazy.load({
    show = false,
    plugins = pkgList,
  })

  -- finally, reload huez again with installed and loaded themes
  loader.reload("huez.nvim")
end

-- -- FIXME: this extra reload is a workaround until we implement
-- -- file reading to get the selected themes
-- M.lazy_flush(require("huez_manager.selected").selected())

return M
