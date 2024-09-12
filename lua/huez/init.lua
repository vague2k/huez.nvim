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
  user_opts = user_opts or {}
  local err = config.set_user_opts(user_opts)
  if err ~= "" then
    error(err, 4)
  end

  config.load_theme_configs()

  config.handle_theme_on_setup()
  -- without scheduling, some vim api calls will not return accurate values
  vim.schedule(setup_usercmds)
end

return M
