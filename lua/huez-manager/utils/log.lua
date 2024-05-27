local config = require("huez.config")
local M = {}

--- util wrapper for vim.notify
---@param msg any
---@param level string
---@return nil
M.notify = function(msg, level)
  if config.current.suppress_messages == true then
    return
  end
  return vim.notify(msg, vim.log.levels[level:upper()], { title = "Huez.nvim" })
end

return M
