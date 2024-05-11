local telescope_actions = require("telescope.actions")
local state = require("telescope.actions.state")

local registry = require("huez_manager.registry")
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
local global_window = {}

M.optimistic_preview_next = function(bufnr)
  telescope_actions.move_selection_next(bufnr)

  ---@type Picker
  local picker = state.get_current_picker(bufnr)
  local row = picker:get_selection_row()

  -- the results list selects index 1 by default, so when the selection moves, we get index == 2
  -- thus, we have to substract 1 from the current index
  local index = picker:get_index(row) - 1
  local window_size = index + 4
  -- reinit the global window to make we only keep track of 5 values at a time
  -- We need this global window so when we go to the previous selection we can slide the window back accordingly
  -- FIXME: how can we shift the window back when going to prev selection using the global window?
  global_window = {}
  for i = index, window_size do
    -- if we go past #pkgs go back to the beginning of the results list
    if i == 0 then
      return
    end

    -- near the end of the list, if the index extends past #pkgs range, shift the list down.
    if i > #pkgs then
      table.remove(global_window, 1)
      break
    end

    table.insert(global_window, pkgs[i].pkgname)
  end
  vim.print(global_window)
end

M.optimistic_preview_prev = function(bufnr)
  telescope_actions.move_selection_previous(bufnr)
end

return M
