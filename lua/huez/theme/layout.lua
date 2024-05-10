local config = require("huez.config")
local M = {}

local picker_conf = config.current.picker

---@param anchor string
---@param width number
---@param height number
---@param prompt_pos? string
M._preset_builder = function(anchor, width, height, prompt_pos)
  local preset = {
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = prompt_pos or "top",
      width = width,
      height = height,
      anchor = anchor,
    },
  }
  return vim.tbl_deep_extend("force", preset, picker_conf.themes)
end

M.picker_pos = function()
  if picker_conf.layout == nil then
    return picker_conf.themes
  end

  if picker_conf.layout == "left" then
    return M._preset_builder("W", 0.15, vim.api.nvim_win_get_height(0))
  end

  if picker_conf.layout == "top" then
    return M._preset_builder("N", 0.3, 0.22)
  end

  if picker_conf.layout == "right" then
    return M._preset_builder("E", 0.15, vim.api.nvim_win_get_height(0))
  end

  if picker_conf.layout == "bottom" then
    return M._preset_builder("S", 0.3, 0.22, "bottom")
  end
end

return M
