local config = require("huez.config")

local M = {}

local create_cmd = function(name, tbl)
  vim.api.nvim_create_user_command(name, tbl, {})
end

local function setup_usercmds()
  create_cmd("Huez", require("huez.ui.test").pick_colorscheme)
end

---@param user_opts Huez.Config?
M.setup = function(user_opts)
  -- this ensures that if a user calls setup without explicit config, the default will be used
  if user_opts then
    config.set(user_opts)
  end

  config.init_cache_file() -- sets up the 'huez-theme' file in nvim cache
  setup_usercmds()
end

return M
