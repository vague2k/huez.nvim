local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local adapter_actions = require("huez.integrations.telescope.actions")
local utils = require("huez.utils")
local api = require("huez.api")

local function pick_colorscheme(opts)
  opts = vim.g.huez_config.picker_opts or {}
  local themes = api.filter_default_themes()
  pickers
    .new(opts, {
      prompt_title = "Huez",
      finder = finders.new_table(themes),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(bufnr, map)
        actions.select_default:replace(function()
          actions.close(bufnr)

          local selection = action_state.get_selected_entry().value
          if selection == nil then
            utils._logger("Huez: must choose valid colorscheme", "ERROR")
          else
            api.save_colorscheme(selection)
          end
        end)

        map("i", "<C-j>", adapter_actions.next_color)
        map("i", "<C-k>", adapter_actions.prev_color)
        map("i", "<C-n>", adapter_actions.next_color)
        map("i", "<C-p>", adapter_actions.prev_color)
        map("i", "<Up>", adapter_actions.prev_color)
        map("i", "<Down>", adapter_actions.next_color)

        map("n", "j", adapter_actions.next_color)
        map("n", "k", adapter_actions.prev_color)
        map("n", "<C-n>", adapter_actions.next_color)
        map("n", "<C-p>", adapter_actions.prev_color)

        return true
      end,
    })
    :find()
end

return {
  pick_colorscheme = pick_colorscheme,
}
