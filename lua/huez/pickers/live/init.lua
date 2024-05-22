local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local telescope_actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local mappings = require("huez.pickers.live.mappings")

local actions = require("huez.pickers.live.actions")
local layout = require("huez.pickers.themes.layout")

local function render()
  -- TODO: let users change pickers opts directly from function
  local opts = layout.picker_pos()
  local pkgs = actions.get_pkgs()

  pickers
    .new(opts, {
      prompt_title = "Huez | Registry",
      finder = finders.new_table({
        results = pkgs,
        ---@param entry ThemeRegistryEntry
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.pkgname,
            ordinal = entry.pkgname,
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
