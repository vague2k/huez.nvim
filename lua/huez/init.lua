local config = require("huez.config")

local M = {}

local function setup_usercmds()
  --- TODO: implement cmp for user commands
  local uc = vim.api.nvim_create_user_command

  uc("Huez", require("huez.pickers").themes, {})
  uc("HuezLive", require("huez.pickers").live, {})
  uc("HuezEnsured", require("huez.pickers").ensured, {})
  uc("HuezFavorites", require("huez.pickers").favorites, {})
end

---@param user_opts Huez.Config?
M.setup = function(user_opts)
  -- this ensures that if a user calls setup without explicit config, the default will be used
  if user_opts then
    config.set(user_opts)
  end

  config.init_cache_file() -- sets up the 'huez-theme' file in nvim cache
  -- without scheduling, some vim api calls will not return accurate values
  vim.schedule(setup_usercmds)
end

return M
