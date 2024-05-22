local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local telescope_actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local mappings = require("huez.pickers.ensured.mappings")

local actions = require("huez.pickers.ensured.actions")
local layout = require("huez.pickers.themes.layout")
local api = require("huez-manager.api")

local function render()
  -- TODO: let users change pickers opts directly from function
  local opts = layout.picker_pos()
  local ensured_installed = api.ensured.installed

  pickers
    .new(opts, {
      prompt_title = "Huez",
      finder = finders.new_table({
        results = ensured_installed,
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(bufnr, map)
        telescope_actions.select_default:replace(function()
          telescope_actions.close(bufnr)

          actions.save_on_select(action_state)
        end)

        mappings.attach(map, actions)

        return true
      end,
    })
    :find()
end

return {
  render = render,
}
