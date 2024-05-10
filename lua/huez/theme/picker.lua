local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local telescope_actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local huez_actions = require("huez.theme.actions")
local huez_layout = require("huez.theme.layout")
local log = require("huez.utils.log")
local colorscheme = require("huez.api").colorscheme

local function pick_colorscheme(opts)
  opts = huez_layout.picker_pos()
  local themes = colorscheme.installed()

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

          -- .get_selected_entry could be nil, so we check for nil before accessing it's value.
          local selection = action_state.get_selected_entry()

          if selection == nil then
            log.notify("Must choose valid colorscheme", "error")
            return
          end

          local theme = selection.value
          colorscheme.save(theme)
          vim.cmd.colorscheme(theme)
          log.notify("Selected " .. theme, "info")
        end)

        map("i", "<C-j>", huez_actions.next_theme)
        map("i", "<C-k>", huez_actions.prev_theme)
        map("i", "<C-n>", huez_actions.next_theme)
        map("i", "<C-p>", huez_actions.prev_theme)
        map("i", "<Up>", huez_actions.prev_theme)
        map("i", "<Down>", huez_actions.next_theme)
        map("i", "<esc>", huez_actions.unload_on_quit)

        map("n", "j", huez_actions.next_theme)
        map("n", "k", huez_actions.prev_theme)
        map("n", "<C-n>", huez_actions.next_theme)
        map("n", "<C-p>", huez_actions.prev_theme)
        map("n", "<esc>", huez_actions.unload_on_quit)

        return true
      end,
    })
    :find()
end

return {
  pick_colorscheme = pick_colorscheme,
}
