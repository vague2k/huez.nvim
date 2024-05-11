local telescope_actions = require("telescope.actions")
local telescope_actions_state = require("telescope.actions.state")
local colorscheme = require("huez.api").colorscheme
local log = require("huez.utils.log")

local M = {}

---Preview next theme in the picker
---@param bufnr integer
M.next_theme = function(bufnr)
  telescope_actions.move_selection_next(bufnr)
  local selected = telescope_actions_state.get_selected_entry()
  vim.cmd.colorscheme(selected[1])
end

---Preview previous theme in the picker
---@param bufnr integer
M.prev_theme = function(bufnr)
  telescope_actions.move_selection_previous(bufnr)
  local selected = telescope_actions_state.get_selected_entry()
  vim.cmd.colorscheme(selected[1])
end

-- Resets the colorscheme preview to the previously selected colorscheme if the telescope prompt was quit
---@param bufnr integer
M.unload_on_quit = function(bufnr)
  telescope_actions.close(bufnr)
  local prev_color = colorscheme.get()
  vim.cmd.colorscheme(prev_color)
end

M.save_on_select = function(action_state)
  -- .get_selected_entry could be nil, so we check for nil before accessing it's value.
  local selection = action_state.get_selected_entry()

  if selection == nil then
    log.notify("Must choose valid colorscheme", "error")
    return
  end

  local theme = selection.value
  colorscheme.save(theme)
  vim.cmd.colorscheme(theme)
  log.notify("Selected " .. theme, "info")
end

return M
