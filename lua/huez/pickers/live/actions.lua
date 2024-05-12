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
  local selected = state.get_selected_entry().value.pkgname

  if vim.tbl_contains(manager.live_themes, selected) then
    vim.cmd.colorscheme(selected)
    return
  end

  manager.live_add(selected)
  manager.lazy_flush()

  vim.cmd.colorscheme(selected)
end

M.optimistic_preview_prev = function(bufnr)
  telescope_actions.move_selection_previous(bufnr)
  local selected = state.get_selected_entry().value.pkgname

  if vim.tbl_contains(manager.live_themes, selected) then
    vim.cmd.colorscheme(selected)
    return
  end

  manager.live_add(selected)
  manager.lazy_flush()
  vim.cmd.colorscheme(selected)
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
