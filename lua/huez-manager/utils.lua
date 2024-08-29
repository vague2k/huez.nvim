local M = {}

---@param msg string
---@param level string
M.notify = function(msg, level)
  vim.notify(msg, vim.log.levels[level:upper()], { title = "Huez.nvim" })
end

return M
