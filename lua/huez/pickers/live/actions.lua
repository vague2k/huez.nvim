local telescope_actions = require("telescope.actions")
local state = require("telescope.actions.state")

local registry = require("huez_manager.registry")
local manager = require("huez_manager.selected")
-- local log = require("huez.utils.log")

local M = {}

M.get_pkgs = function()
  local pkgs = {}
  for key, value in pairs(registry) do
    if key == value.pkgname then
      table.insert(pkgs, value)
    end
  end

  table.sort(pkgs, function(a, b)
    return a.pkgname:lower() < b.pkgname:lower()
  end)
  return pkgs
end

M.optimistic_preview_next = function(bufnr)
  telescope_actions.move_selection_next(bufnr)
  ---@type ThemeRegistryEntry
  local entry = state.get_selected_entry().value

  -- TODO: needs a refactor
  if vim.tbl_contains(manager.live_themes, entry.pkgname) then
    if not entry.colorscheme then
      vim.cmd.colorscheme(entry.pkgname)
      return
    else
      vim.cmd.colorscheme(entry.colorscheme)
    end
    return
  end

  manager.live_add(entry.pkgname)
  manager.lazy_flush()

  if entry.colorscheme then
    vim.cmd.colorscheme(entry.colorscheme)
  else
    vim.cmd.colorscheme(entry.pkgname)
  end
end

M.optimistic_preview_prev = function(bufnr)
  telescope_actions.move_selection_previous(bufnr)
  ---@type ThemeRegistryEntry
  local entry = state.get_selected_entry().value

  -- TODO: needs a refactor
  if vim.tbl_contains(manager.live_themes, entry.pkgname) then
    if not entry.colorscheme then
      vim.cmd.colorscheme(entry.pkgname)
      return
    else
      vim.cmd.colorscheme(entry.colorscheme)
    end
    return
  end

  manager.live_add(entry.pkgname)
  manager.lazy_flush()

  if entry.colorscheme then
    vim.cmd.colorscheme(entry.colorscheme)
  else
    vim.cmd.colorscheme(entry.pkgname)
  end
end

M.unload_live_themes = function(bufnr)
  telescope_actions.close(bufnr)
  for _, value in ipairs(M.get_pkgs()) do
    if vim.tbl_contains(manager.live_themes, value.pkgname) then
      manager.live_remove(value.pkgname)
    end
  end
  manager.lazy_flush()
end

return M
