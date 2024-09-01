local config = require("huez.config")
local commands = require("huez.commands")
local M = {}

---@param opts? Huez.Config
M.setup = function(opts)
  opts = opts or {}
  local err = config.set_user_opts(opts)
  if err ~= "" then
    error(err, 4)
  end

  vim.schedule(function()
    config.handle_huez_colorscheme()
    commands.setup()
  end)
end

return M
