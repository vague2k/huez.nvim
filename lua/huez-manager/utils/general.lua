local M = {}

---@param colorscheme string
---@return boolean
M.colorscheme_exists = function(colorscheme)
  local ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
  vim.cmd.colorscheme(vim.g.colors_name)
  return ok
end

return M
