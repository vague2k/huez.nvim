local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local telescope_actions = require("telescope.actions")

local config = require("huez.config")

local M = {}

---@param picker "themes"|"live"|"ensured"
M.layout_builder = function(picker)
  ---@type Huez.Config.PickersOpts
  local picker_conf = config.current.picker[picker]
  local preset = {
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {},
  }

  if picker_conf.layout == nil then
    return picker_conf.opts
  end

  if picker_conf.layout == "left" then
    preset.layout_config.anchor = "W"
    preset.layout_config.width = 0.15
    preset.layout_config.height = vim.api.nvim_win_get_height(0)
    preset.layout_config.prompt_position = "top"
  end

  if picker_conf.layout == "top" then
    preset.layout_config.anchor = "N"
    preset.layout_config.width = 0.3
    preset.layout_config.height = 0.22
    preset.layout_config.prompt_position = "top"
  end

  if picker_conf.layout == "right" then
    preset.layout_config.anchor = "E"
    preset.layout_config.width = 0.15
    preset.layout_config.height = vim.api.nvim_win_get_height(0)
    preset.layout_config.prompt_position = "top"
  end

  if picker_conf.layout == "bottom" then
    preset.layout_config.anchor = "S"
    preset.layout_config.width = 0.3
    preset.layout_config.height = 0.22
    preset.layout_config.prompt_position = "bottom"
  end

  return vim.tbl_deep_extend("force", preset, picker_conf.opts)
end

---@class Huez.PickerBuilder
---@field picker "themes"|"live"|"ensured"
---@field prompt_title string
---@field finder table
---@field default_action? function
---@field mappings function

---@param opts Huez.PickerBuilder
M.picker_builder = function(opts)
  local telescope_opts = M.layout_builder(opts.picker)
  opts.default_action = opts.default_action or function() end

  pickers
    .new(telescope_opts, {
      prompt_title = opts.prompt_title,
      finder = finders.new_table(opts.finder),
      sorter = conf.generic_sorter(telescope_opts),
      attach_mappings = function(bufnr, map)
        telescope_actions.select_default:replace(function()
          telescope_actions.close(bufnr)

          opts.default_action(bufnr)
        end)

        opts.mappings(map)

        return true
      end,
    })
    :find()
end

return M
