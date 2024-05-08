local loader = require("lazy.core.loader")
local lazy = require("lazy")
local plugins = require("lazy.core.plugin")
local registry = require("huez_manager.registry")
local installed = require("huez.api.colorscheme").installed()
local utils = require("huez_manager.utils")

local M = {}

---@alias InstalledThemes string[]
---
--@type InstalledThemes
M.favourites = utils.load_themes("favourites")
M.live_themes = utils.load_themes("live")

---@return InstalledThemes
function M.selected()
  return vim.tbl_extend("force", M.live_themes, M.favourites)
end

---@param theme string
---@return nil
function M.live_add(theme)
  vim.notify("Adding " .. theme .. " to live themes")
  utils.add_theme("live", theme)
  M.live_themes = utils.load_themes("live")
end

---@param theme string
---@return nil
function M.live_remove(theme)
      utils.remove_theme("live", theme)
      M.live_themes = utils.load_themes("live")
end

---@param theme string
---@return nil
function M.favourite_add(theme)
  vim.notify("Adding " .. theme .. " to favourites")
  utils.add_theme("favourites", theme)
  M.favourites = utils.load_themes("favourites")
end

---@param theme string
---@return nil
function M.favourite_remove(theme)
      utils.remove_theme("favourites", theme)
      M.favourites = utils.load_themes("favourites")
end

---@param plugins_list? InstalledThemes
---@return nil
M.lazy_flush = function(plugins_list)
  loader.reload("huez.nvim")
  plugins_list = plugins_list or M.selected()
  vim.notify("analyzing plugins" .. vim.inspect(plugins_list))
  local pkgList = {}
  for _, value in ipairs(plugins_list) do
    if not vim.tbl_contains(installed, value) then
      table.insert(pkgList, registry[value].pkgname)
    end
  end
  vim.notify("Flushing plugins" .. vim.inspect(pkgList))
  if #pkgList == 0 then
    -- No plugins to flush
    -- Anything that is temporary will be flushed on next nvim restart
    return
  end
  plugins.load()
  vim.api.nvim_exec_autocmds("User", { pattern = "LazyReload", modeline = false })
  pcall(lazy.install({ show = false, plugins = pkgList, wait = true }))
  lazy.load({ show = false, plugins = pkgList })
  loader.reload("huez.nvim")
end


return M
