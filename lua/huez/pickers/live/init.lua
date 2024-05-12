local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local telescope_actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local mappings = require("huez.pickers.live.mappings")

local actions = require("huez.pickers.live.actions")
local layout = require("huez.pickers.themes.layout")

local function render()
  local opts = layout.picker_pos()

  pickers
    .new(opts, {
      prompt_title = "Huez",
      finder = finders.new_table({
        results = actions.get_pkgs(),
        ---@param entry ThemeRegistryEntry
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.pkgname,
            ordinal = entry.url,
          }
        end,
      }),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(bufnr, map)
        telescope_actions.select_default:replace(function()
          telescope_actions.close(bufnr)
          local selection = action_state.get_selected_entry()

          if selection == nil then
            return
          end

          local theme = selection.ordinal
          vim.print(theme)
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
