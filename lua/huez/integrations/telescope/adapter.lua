local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local telescope_themes = require("telescope.themes")

local adapter_actions = require("huez.integrations.telescope.actions")
local utils = require("huez.utils")
local api = require("huez.api")

local function pick_colorscheme(opts)
  opts = vim.g.huez_config.picker_opts or telescope_themes.get_dropdown()
  local themes = api.filter_default_themes()
  
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
        actions.select_default:replace(function()
          actions.close(bufnr)

          -- .get_selected_entry could be nil, so we check for nil before accessing it's value.
          local selection = action_state.get_selected_entry()

          if selection == nil then
            utils.log_error("Huez: must choose valid colorscheme")
          else
            api.save_colorscheme(selection.value)
          end
        end)

        map("i", "<C-j>", adapter_actions.next_color)
        map("i", "<C-k>", adapter_actions.prev_color)
        map("i", "<C-n>", adapter_actions.next_color)
        map("i", "<C-p>", adapter_actions.prev_color)
        map("i", "<Up>", adapter_actions.prev_color)
        map("i", "<Down>", adapter_actions.next_color)
        map("i", "<esc>", adapter_actions.reset_if_not_pick)

        map("n", "j", adapter_actions.next_color)
        map("n", "k", adapter_actions.prev_color)
        map("n", "<C-n>", adapter_actions.next_color)
        map("n", "<C-p>", adapter_actions.prev_color)
        map("n", "<esc>", adapter_actions.reset_if_not_pick)

        return true
      end,
    })
    :find()
end

return {
  pick_colorscheme = pick_colorscheme,
}
