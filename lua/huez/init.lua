local config = require("huez.config")
local utils = require("huez.utils")

local M = {}

local create_cmd = function(name, tbl)
  vim.api.nvim_create_user_command(name, tbl, {})
end

local function setup_usercmds()
  create_cmd("Huez", require("huez.ui.test").pick_colorscheme)
end

---@param user_opts Huez.Config?
M.setup = function(user_opts)
  if user_opts then
    config.setup_user_config(user_opts)
  end

  -- check if the "huez-theme" file exists, if it doesn't create it
  -- and initiliaze the theme as whatever the fallback is
  local file_exist = io.open(config.current.file_path, "r")
  if file_exist ~= nil then
    vim.cmd("colorscheme " .. file_exist:read())
    file_exist:close()
  else
    local file = io.open(config.current.file_path, "w+")
    if file then
      file:write(config.current.fallback)
      utils.log_warning(
        "No 'huez-theme' file was found, so one was created at \n"
          .. config.current.file_path
          .. " with the theme '"
          .. config.current.fallback
          .. "' as a fallback."
      )
      file:close()
    end
    local newly_created_file = io.open(config.current.file_path, "r")
    if newly_created_file then
      vim.cmd("colorscheme " .. newly_created_file:read())
      newly_created_file:close()
    end
  end

  setup_usercmds()
end

return M
