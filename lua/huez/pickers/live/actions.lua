local telescope_actions = require("telescope.actions")
local telescope_action_state = require("telescope.actions.state")

local registry = require("huez-manager.registry")
local selected = require("huez-manager.api.selected")
local live_utils = require("huez.pickers.live.utils")
local api = require("huez-manager.api")
local log = require("huez-manager.utils.log")

local M = {}

---@return ThemeRegistryEntry[]
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
  ---@type ThemeRegistryEntry
  local entry = telescope_action_state.get_selected_entry().value
  live_utils.load_currently_installed(entry)
end

M.optimistic_preview_prev = function(bufnr)
  telescope_actions.move_selection_previous(bufnr)
  ---@type ThemeRegistryEntry
  local entry = telescope_action_state.get_selected_entry().value
  live_utils.load_currently_installed(entry)
end

M.unload_live_themes = function(bufnr)
  telescope_actions.close(bufnr)
  for _, value in ipairs(M.get_pkgs()) do
    if vim.tbl_contains(api.live.installed, value.pkgname) then
      api.live.remove(value.pkgname)
    end
  end
  selected.lazy_flush()
end

M.add_to_ensured = function()
  ---@type ThemeRegistryEntry
  local entry = telescope_action_state.get_selected_entry().value

  api.ensured.add(entry.pkgname)
  log.notify("Added the '" .. entry.pkgname .. "' Theme to ensure installed!", "info")
end

return M
