local config = require("huez.config")
local M = {}

-- calculates dimensions and position of the picker based on config values
M._calc_pos = function()
  local picker_conf = config.current.picker
  local win_width = vim.api.nvim_win_get_width(0)
  local win_height = vim.api.nvim_win_get_height(0)
  local width = picker_conf.width
  local height = picker_conf.height
  local row = picker_conf.position.row
  local col = picker_conf.position.col

  if picker_conf.preset == nil then
    return {
      width = width,
      height = height or win_height,
      relative = "editor",
      position = {
        row = row,
        col = col or win_width + width,
      },
    }
  end

  if picker_conf.preset == "right" then
    return {
      width = 40,
      height = win_height,
      position = {
        row = 0,
        col = win_width + width,
      },
    }
  end

  if picker_conf.preset == "left" then
    return {
      width = 40,
      height = win_height,
      position = {
        row = 0,
        col = 0 - width,
      },
    }
  end

  if picker_conf.preset == "center" then
    return {
      width = 80,
      height = math.floor(win_height / 2),
      position = {
        row = "50%",
        col = "50%",
      },
    }
  end
end

return M
