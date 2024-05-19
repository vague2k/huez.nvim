local M = {}

--- util wrapper for vim.notify
---@param msg any
---@param level string
---@return nil
M.notify = function(msg, level)
  return vim.notify(msg, vim.log.levels[level:upper()], { title = "Huez.nvim" })
end

return M
