local telescope_actions = require("telescope.actions")
local telescope_actions_state = require("telescope.actions.state")

local actions = {}

---Preview color scheme when going to the next selection
---@param bufnr integer
actions.next_color = function(bufnr)
  telescope_actions.move_selection_next(bufnr)
  local selected = telescope_actions_state.get_selected_entry()
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)
end

---Preview color scheme when going to the previous selection
---@param bufnr integer
actions.prev_color = function(bufnr)
  telescope_actions.move_selection_previous(bufnr)
  local selected = telescope_actions_state.get_selected_entry()
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)
end

return actions
