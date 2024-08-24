local config = require("huez.config")
local M = {}

---@param msg string
---@param level string
local log = function(msg, level)
  vim.notify(msg, vim.log.levels[level:upper()], { title = "Huez.nvim" })
end

---@param opts? Huez.Config
M.setup = function(opts)
  if opts then
    local err = config.set_user_opts(opts)
    if err ~= "" then
      log(err, "error")
    end
  end
end

return M
