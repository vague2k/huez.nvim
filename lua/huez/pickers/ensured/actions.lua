local telescope_actions = require("telescope.actions")
local telescope_action_state = require("telescope.actions.state")

local registry = require("huez-manager.registry")
local api = require("huez-manager.api")
local log = require("huez-manager.utils.log")

local M = {}

---Preview next theme in the picker
---@param bufnr integer
M.next_theme = function(bufnr)
  telescope_actions.move_selection_next(bufnr)
  local pkgname = telescope_action_state.get_selected_entry().value
  local entry = registry[pkgname]
  vim.cmd.colorscheme(entry.colorscheme or entry.pkgname)
end

---Preview previous theme in the picker
---@param bufnr integer
M.prev_theme = function(bufnr)
  telescope_actions.move_selection_previous(bufnr)
  local pkgname = telescope_action_state.get_selected_entry().value
  local entry = registry[pkgname]
  vim.cmd.colorscheme(entry.colorscheme or entry.pkgname)
end

-- Resets the colorscheme preview to the previously selected colorscheme if the telescope prompt was quit
---@param bufnr integer
M.unload_on_quit = function(bufnr)
  telescope_actions.close(bufnr)
  local prev_color = api.colorscheme.get()
  vim.cmd.colorscheme(prev_color)
end

M.save_on_select = function(action_state)
  local pkgname = action_state.get_selected_entry().value
  local entry = registry[pkgname]
  local theme = entry.colorscheme or entry.pkgname

  api.colorscheme.save(theme)
  vim.cmd.colorscheme(theme)
  log.notify("Selected " .. theme, "info")
end

M.remove_from_ensured = function()
  local pkgname = telescope_action_state.get_selected_entry().value
  local entry = registry[pkgname]

  api.ensured.remove(entry.pkgname)
  log.notify("Removed '" .. entry.pkgname .. "'. It will no longer be installed.", "warn")
end

return M
