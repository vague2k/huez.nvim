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
  local index = picker:get_selection_row()

  global_window = {}
  for i = index, index + 4 do
    -- if we reach the end of the array, starting from the beg. there is nothing else to shift
    if i == 0 or i > #pkgs then
      return
    end

    table.insert(global_window, pkgs[i].pkgname)
  end
  vim.print(global_window)
end

M.optimistic_preview_prev = function(bufnr)
  telescope_actions.move_selection_previous(bufnr)
  local picker = state.get_current_picker(bufnr)
  local index = picker:get_selection_row() + 1

  -- FIXME: my head fucking hurts and i give up

  --[[ -- vim.print(index)
  -- if we reach the beg. of the array, starting from the end there is nothing else to shift
  if index == 1 then
    return
  end

  -- if a user immediately starts from the end...
  if index == #pkgs and #global_window <= 0 then
    vim.print("STARTING FROM END")
    for i = index, index - 4, -1 do
      -- global_window = {}
      table.remove(global_window, i)
      table.insert(global_window, pkgs[i].pkgname)
    end
    vim.print(global_window)
    return
  end

  -- if window slides backwards, after moving forwards at least once,
  if #pkgs - 4 == index and #global_window > 4 then
    vim.print(" MORE THAN 4")
    table.remove(global_window, #global_window)
    table.insert(global_window, 1, pkgs[index].pkgname)
    vim.print(global_window)
    return
  end

  -- -- if a user immediately starts from the end...
  -- if #global_window <= 0 then
  --   for i = index, index - 4, -1 do
  --     -- vim.print(pkgs[i])
  --     global_window = {}
  --     table.insert(global_window, pkgs[i].pkgname)
  --   end
  --   return
  -- end

  vim.print(global_window) ]]
end

return M
