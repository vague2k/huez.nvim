local telescope_actions = require("telescope.actions")
local state = require("telescope.actions.state")

local registry = require("huez_manager.registry")
local fn = require("huez.utils.fn")
-- local manager = require("huez_manager.selected")
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

local pkgs = M.get_pkgs()

M.optimistic_preview_next = function(bufnr)
  telescope_actions.move_selection_next(bufnr)

  ---@type Picker
  local picker = state.get_current_picker(bufnr)
  local row = picker:get_selection_row()

  -- the results picker already has a cursor on the 1st index, so when the selection moves, we get index == 2
  -- thus, we have to substract 1 from the current index
  local index = picker:get_index(row) - 1

  local window = {}
  for i = index, index + 4 do
    if i > #pkgs then
      table.remove(window, 1)
      vim.print(window)
      break
    else
      index = 1
    end
    -- FIXME: errors when going past #pkgs in the results window
    table.insert(window, pkgs[i].pkgname)
  end
  vim.print(window)
end

M.optimistic_preview_prev = function(bufnr)
  telescope_actions.move_selection_previous(bufnr)
end

return M
