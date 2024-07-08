local telescope_action_state = require("telescope.actions.state")

local actions = require("huez.pickers.themes.actions")
local picker_utils = require("huez.pickers.utils")
local mappings = require("huez.pickers.themes.mappings")
local api = require("huez-manager.api")

local function render(opts)
  opts = opts or {}
  local themes = api.colorscheme.installed()

  local current_scheme = vim.g.colors_name or "default"
  local default_index = 1
  for i, theme in ipairs(themes) do
    if theme == current_scheme then
      default_index = i
      break
    end
  end
  opts.default_selection_index = default_index

  picker_utils.picker_builder({
    picker = "themes",
    prompt_title = "Huez",
    finder = {
      results = themes,
    },
    default_action = function()
      actions.save_on_select(telescope_action_state)
    end,
    mappings = function(map)
      mappings.attach(map, actions)
    end,
  }, opts)
end

return {
  render = render,
}
