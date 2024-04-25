local utils = require("huez.utils")

---@alias Huez.Integration "telescope"|"vim"

---@class Huez.Config
---@field file_path string
---@field fallback string
---@field exclude string[]

---@type Huez.Config
local default_config = {
  -- the filepath where your theme will be saved
  file_path = vim.fs.normalize(vim.fn.stdpath("cache")) .. "/huez-theme",
  -- the fallback theme which will be written to a new "huez-theme" file in case the "huez-theme" file does not exist
  fallback = "default",
  -- a list of ugly theme that come with neovim that you probably don't want to choose from in the picker
  exclude = {
    "default",
    "desert",
    "evening",
    "industry",
    "koehler",
    "morning",
    "murphy",
    "pablo",
    "peachpuff",
    "ron",
    "shine",
    "slate",
    "torte",
    "zellner",
    "blue",
    "darkblue",
    "delek",
    "quiet",
    "elflord",
    "habamax",
    "lunaperche",
  },
}
local config = {}

vim.g.huez_config = default_config

---@param opts Huez.Config
config.setup = function(opts)
  opts = opts or {}
  local prev_conf = vim.g.huez_config or default_config
  vim.g.huez_config = vim.tbl_deep_extend("force", prev_conf, opts) or default_config

  -- check if the "huez-theme" file exists, if it doesn't create it
  local file_exist = io.open(vim.g.huez_config.file_path, "r")
  if file_exist ~= nil then
    vim.cmd("colorscheme " .. file_exist:read())
    file_exist:close()
  else
    local file = io.open(vim.g.huez_config.file_path, "w+")
    if file then
      file:write(vim.g.huez_config.fallback)
      utils.log_error("No 'huez-theme' file was detected, so one was created at: " .. vim.g.huez_config.file_path)
      file:close()
    end
  end
end

return config
