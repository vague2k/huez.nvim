---@alias Huez.Integration "telescope"|"vim"

---@class Huez.Config
---@field file_path string
---@field fallback string
---@field omit string[]
---@field picker Huez.Integration
---@field picker_opts? table

---@type Huez.Config
local default_config = {
  -- the filepath where your theme will be saved
  file_path = vim.fs.normalize(vim.fn.stdpath("config")) .. "/.nvim.huez.lua",
  -- the fallback theme in case Huez fails or bugs out for some reason
  fallback = "default",
  -- a list of ugly theme that come with neovim that you probably don't want to choose from in the picker
  omit = {
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
  -- optional: by default, picker will be vim.ui.select, you can also choose "telescope"
  picker = "telescope",
  -- optional: if using telescope, picker_opts controls the dropdown style
  picker_opts = require("telescope.themes").get_dropdown({}),
}
local config = {}

vim.g.huez_config = default_config

---@param opts Huez.Config
config.setup = function(opts)
  opts = opts or {}
  local prev_conf = vim.g.huez_config or default_config
  vim.g.huez_config = vim.tbl_deep_extend("force", prev_conf, opts) or default_config
end

return config
