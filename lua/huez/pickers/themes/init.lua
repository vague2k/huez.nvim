local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local telescope_actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local actions = require("huez.pickers.themes.actions")
local layout = require("huez.pickers.themes.layout")
local mappings = require("huez.pickers.themes.mappings")
local api = require("huez-manager.api")

local function render()
  -- TODO: let users change pickers opts directly from function
  local opts = layout.picker_pos()
  local themes = api.colorscheme.installed()

  -- set the current color scheme as a preselection in the picker for better UX
  local current_scheme = vim.g.colors_name or "default"
  local default_index = 1
  for i, theme in ipairs(themes) do
    if theme == current_scheme then
      default_index = i
      break
    end
  end
  opts.default_selection_index = default_index

  pickers
    .new(opts, {
      prompt_title = "Huez",
      finder = finders.new_table(themes),
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
