local telescope_actions = require("telescope.actions")
local telescope_actions_state = require("telescope.actions.state")
local api = require("huez.api")

local actions = {}

---Preview color scheme when going to the next selection in the prompt
---@param bufnr integer
actions.next_color = function(bufnr)
  telescope_actions.move_selection_next(bufnr)
  local selected = telescope_actions_state.get_selected_entry()
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)
end

---Preview color scheme when going to the previous selection in the prompt
---@param bufnr integer
actions.prev_color = function(bufnr)
  telescope_actions.move_selection_previous(bufnr)
  local selected = telescope_actions_state.get_selected_entry()
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)
end

-- Resets the colorscheme preview to the previously selected colorscheme if the telescope prompt was quit
---@param bufnr integer
actions.reset_if_not_pick = function(bufnr)
  telescope_actions.close(bufnr)
  local prev_color = api.get_colorscheme()
  local cmd = "colorscheme " .. prev_color
  vim.cmd(cmd)
end

return actions
