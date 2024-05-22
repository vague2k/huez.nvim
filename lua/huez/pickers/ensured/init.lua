local telescope_action_state = require("telescope.actions.state")

local actions = require("huez.pickers.ensured.actions")
local picker_utils = require("huez.pickers.utils")
local mappings = require("huez.pickers.ensured.mappings")
local api = require("huez-manager.api")

local function render()
  local ensured_installed = api.ensured.installed
  picker_utils.picker_builder({
    picker = "ensured",
    prompt_title = "Huez | Ensured",
    finder = {
      results = ensured_installed,
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
