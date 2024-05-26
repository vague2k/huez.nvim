local telescope_action_state = require("telescope.actions.state")

local actions = require("huez.pickers.themes.actions")
local picker_utils = require("huez.pickers.utils")
local mappings = require("huez.pickers.themes.mappings")
local api = require("huez-manager.api")

local function render()
  local themes = api.colorscheme.installed()

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
  })
end

return {
  render = render,
}
