local M = {}

---@param msg string
---@param level string
M.notify = function(msg, level)
  vim.notify(msg, vim.log.levels[level:upper()], { title = "Huez.nvim" })
end

---@param colorscheme string
---@return boolean
M.colorscheme_exists = function(colorscheme)
  local ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
  local exists
  if not ok then
    exists = false
  else
    exists = true
  end
  vim.cmd.colorscheme(vim.g.colors_name)
  return exists
end

return M
