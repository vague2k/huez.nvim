---@param msg string
local function log_error(msg)
  return vim.notify(msg, vim.log.levels.ERROR, { title = "Huez.nvim" })
end

---@param msg string
local function log_info(msg)
  return vim.notify(msg, vim.log.levels.INFO, { title = "Huez.nvim" })
end

return {
  log_error = log_error,
  log_info = log_info,
}
