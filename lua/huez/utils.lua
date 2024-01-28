---@alias Huez.Utils.Log_Level "TRACE" | "DEBUG" | "INFO" | "WARN" | "ERROR" | "OFF"

---@param msg string
---@param log_level Huez.Utils.Log_Level
local function _logger(msg, log_level)
  vim.notify(msg, vim.log.levels[log_level], { title = "Huez" })
end

return {
  _logger = _logger,
}
