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

--- util wrapper for vim.notify_once
---@param msg any
---@param level string
---@param opts? table
---@return nil
M.notify_once = function(msg, level, opts)
  opts = vim.tbl_deep_extend("force", { title = "Huez.nvim" }, opts or {})
  if config.current.suppress_messages == true then
    return
  end
  return vim.notify_once(msg, vim.log.levels[level:upper()], opts)
end

return M
