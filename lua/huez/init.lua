local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local huez_actions = require("huez.actions")
local huez_conf = require("huez.config")
local huez_persist = require("huez.persist")

local M = {}

local function filter_default_themes()
  local default_themes = huez_conf.default_config.omit
  local all_installed_themes = vim.fn.getcompletion("", "color", true)

  local default_omitted = {}

  for _, themes in ipairs(all_installed_themes) do
    if not vim.tbl_contains(default_themes, themes) then
      table.insert(default_omitted, themes)
    end
  end

  return default_omitted
end

-- TODO: reset colorscheme if picker is closed without selection
M.pick_colorscheme = function(opts)
  opts = opts or {}
  pickers
    .new(huez_conf.default_config.picker_opts, {
      prompt_title = "Huez",
      finder = finders.new_table(filter_default_themes()),
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(bufnr, map)
        actions.select_default:replace(function()
          actions.close(bufnr)

          local selection = action_state.get_selected_entry()
          local colorscheme

          if selection == nil then
            vim.notify("Huez: selection isn't valid")
          else
            colorscheme = selection[1]
          end

          huez_actions.save_colorscheme(colorscheme)
        end)

        map("i", "<C-j>", huez_actions.next_color)
        map("i", "<C-k>", huez_actions.prev_color)
        map("i", "<C-n>", huez_actions.next_color)
        map("i", "<C-p>", huez_actions.prev_color)
        map("i", "<Up>", huez_actions.prev_color)
        map("i", "<Down>", huez_actions.next_color)

        map("n", "j", huez_actions.next_color)
        map("n", "k", huez_actions.prev_color)
        map("n", "<C-n>", huez_actions.next_color)
        map("n", "<C-p>", huez_actions.prev_color)

        return true
      end,
    })
    :find()
end

M.setup = function(opts)
  opts = opts or {}
  huez_persist.check_if_file_exists()
  for k, v in pairs(opts) do
    M[k] = v
  end

  vim.api.nvim_create_user_command("Huez", M.pick_colorscheme, {})
end

return M
