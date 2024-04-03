---@param msg string
local function log_error(msg)
  vim.notify(msg, vim.log.levels.ERROR, { title = "Huez" })
end

return {
  log_error = log_error,
}
