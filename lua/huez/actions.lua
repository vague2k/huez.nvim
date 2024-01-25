local telescope_actions = require("telescope.actions")
local telescope_actions_state = require("telescope.actions.state")
local default_conf = require("huez.config").default_config
local persist = require("huez.persist")

local actions = {}

---Preview color scheme when going to the next selection
---@param bufnr buffer
actions.next_color = function(bufnr)
  telescope_actions.move_selection_next(bufnr)
  local selected = telescope_actions_state.get_selected_entry()
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)
end

---Preview color scheme when going to the previous selection
---@param bufnr buffer
actions.prev_color = function(bufnr)
  telescope_actions.move_selection_previous(bufnr)
  local selected = telescope_actions_state.get_selected_entry()
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)
end

actions.get_colorscheme = function()
  local file, err = io.open(default_conf.file_path, "r")

  if not file then
    return nil, print("Error reading file: ", err)
  end

  local line = file:read()
  file:close()

  return line
end

---@param colorscheme string
actions.save_colorscheme = function(colorscheme)
  vim.cmd("hi clear")
  vim.cmd("syntax reset")
  vim.cmd("colorscheme " .. colorscheme)
  persist.check_if_file_exists()
  persist._write_theme_to_file(colorscheme)
end

return actions
