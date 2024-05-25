local telescope_action_state = require("telescope.actions.state")

local actions = require("huez.pickers.favorites.actions")
local picker_utils = require("huez.pickers.utils")
local mappings = require("huez.pickers.favorites.mappings")
local api = require("huez-manager.api")

local function render()
  local favorited_themes = api.favorites.list()

  picker_utils.picker_builder({
    picker = "favorites",
    prompt_title = "Huez | Favorites",
    finder = {
      results = favorited_themes,
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
