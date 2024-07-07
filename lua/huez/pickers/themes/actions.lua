local telescope_actions = require("telescope.actions")
local telescope_actions_state = require("telescope.actions.state")
local api = require("huez-manager.api")
local log = require("huez-manager.utils.log")
local conf = require("huez.config")

local M = {}

---Preview next theme in the picker
---@param bufnr integer
M.next_theme = function(bufnr)
  telescope_actions.move_selection_next(bufnr)
  local selected = telescope_actions_state.get_selected_entry()
  conf.set_theme(selected[1])
end

---Preview previous theme in the picker
---@param bufnr integer
M.prev_theme = function(bufnr)
  telescope_actions.move_selection_previous(bufnr)
  local selected = telescope_actions_state.get_selected_entry()
  conf.set_theme(selected[1])
end

-- Resets the colorscheme preview to the previously selected colorscheme if the telescope prompt was quit
---@param bufnr integer
M.unload_on_quit = function(bufnr)
  telescope_actions.close(bufnr)
  local prev_color = api.colorscheme.get()
  conf.set_theme(prev_color)
end

--- Saves the selected colorscheme to `huez-theme`
M.save_on_select = function(action_state)
  -- .get_selected_entry could be nil, so we check for nil before accessing it's value.
  local selection = action_state.get_selected_entry()

  if selection == nil then
    log.notify("Must choose valid colorscheme", "error")
    return
  end

  local theme = selection.value
  api.colorscheme.save(theme)
  conf.set_theme(theme)
  log.notify("Selected " .. theme, "info")
end

M.add_to_favorites = function()
  local selection = telescope_actions_state.get_selected_entry()

  if selection == nil then
    log.notify("Must choose valid colorscheme", "error")
    return
  end

  local theme = selection.value
  api.favorites.add(theme)
  log.notify("Added '" .. theme .. "' to your favorites!", "info")
end

return M
