local utils = require("huez-manager.utils.general")
local M = {}

--- Same thing as log from utils, but implemented here to prevent circular imports
---@param msg string
---@param level string
local log = function(msg, level)
  if not M.current.suppress_messages then
    vim.notify(msg, vim.log.levels[level:upper()], { title = "Huez.nvim" })
  end
end

---@class Huez.Config.PickersOpts
---@field layout "left"|"top"|"right"|"bottom"|nil
---@field opts table

---@class Huez.Config.Pickers
---@field themes Huez.Config.PickersOpts
---@field favorites Huez.Config.PickersOpts
---@field live Huez.Config.PickersOpts
---@field ensured Huez.Config.PickersOpts

---@class Huez.Config
---@field path? string
---@field fallback? string
---@field suppress_messages? boolean
---@field theme_config_module? string
---@field exclude? string[]
---@field picker? Huez.Config.Pickers

---@alias ThemeSetter fun(theme: string): boolean
---@class Huez.ThemeConfig
---@field styles? string[] -- this denotes the styles like moon, night, day, etc.
---@field set_theme ThemeSetter

---@class Huez.InternalConfig
-- TODO: write a config validator
local DEFAULT_SETTINGS = {
  ---@type string
  path = vim.fs.normalize(vim.fn.stdpath("data") --[[@as string]]) .. "/huez",
  ---@type string
  fallback = "default",
  ---@type boolean
  suppress_messages = true,
  ---@type string
  theme_config_module = nil,
  ---@type string[]
  exclude = {
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
    "zaibatsu",
    "wildcharm",
    "sorbet",
    "vim",
  },

  ---@type Huez.Config.Pickers
  picker = {
    themes = {
      layout = "right",
      opts = {},
    },
    favorites = {
      layout = "right",
      opts = {},
    },
    live = {
      layout = "right",
      opts = {},
    },
    ensured = {
      layout = "right",
      opts = {},
    },
  },
}

M._DEFAULT_SETTINGS = DEFAULT_SETTINGS

---@class Huez.InternalConfig
M.current = M._DEFAULT_SETTINGS

---@type string
M.current.huez_theme_file = M.current.path .. "/huez-theme" -- If you're seeing this note, this value exists

--- validates a user's config and returns an error if validation fails.
---@param user Huez.Config
---@return string
M.validate_user_config = function(user)
  -- check cases where nothing (nil) or empty table is passed to the setup func
  -- in each case the defaults will be used, thus no need to validating
  if not user or vim.tbl_isempty(user) then
    return ""
  end

  -- wrapping vim.validate in a protected call to capture the error for use later
  local ok, err = pcall(vim.validate, {
    path = { user.path, "string" },
    fallback = { user.fallback, "string" },
    exclude = { user.exclude, "table" },
  })
  if not ok and err ~= nil then
    return "Huez.Config." .. err
  end

  return ""
end

---@param user_opts Huez.Config
---@return string
M.set_user_opts = function(user_opts)
  M.current = vim.tbl_deep_extend("force", M.current, user_opts)
  local err = M.validate_user_config(M.user)
  if err ~= "" then
    return err
  end

  return ""
end

---@type table<string, ThemeSetter>
M.theme_setters = {}

-- Will load all the theme configs into memory.
M.load_theme_configs = function()
  local theme_config_module = M.current.theme_config_module
  if theme_config_module == nil then
    return
  end
  -- Convert import string to dir path string to check if dir exists
  -- TODO: find a better way to check this [pref like Lazy.nvim]
  local theme_config_dir = vim.fn.stdpath("config") .. "/lua/" .. vim.fn.substitute(theme_config_module, ".", "/", "g")
  if vim.fn.isdirectory(theme_config_dir) == 0 then
    log("directory not found to load themes from", "ERROR")
    return
  end

  local api = require("huez-manager.api")
  for _, theme in pairs(api.colorscheme.installed(M.current.exclude)) do
    local ok
    ---@type Huez.ThemeConfig
    local conf

    ok, conf = pcall(require, theme_config_module .. "." .. theme)
    -- if cannot load/find config, move on
    if not ok then
      goto continue
    end

    -- For cases where styles is empty/ Styles are shipped as separate schemes
    M.theme_setters[theme] = conf.set_theme

    if conf.styles == nil then
      goto continue
    end

    for _, theme_style in pairs(conf.styles) do
      M.theme_setters[theme .. "-" .. theme_style] = conf.set_theme
    end

    ::continue::
  end
end

--- Set the chosen colorscheme. Keeps in mind any theme config the user has made.
---
--- If no explicit config is found, pcall to :colorscheme
---@param theme? string
---@return boolean
M.set_theme = function(theme)
  if theme == nil then
    log("No theme selected", "INFO")
    return false
  end

  if M.theme_setters[theme] ~= nil then
    return M.theme_setters[theme](theme)
  end

  vim.cmd("set background=dark")
  local ok, _ = pcall(vim.cmd.colorscheme, theme)

  return ok
end

-- if falling back to a user fallback colorscheme fails, ultimately fallback to neovim's default
local fallback = function()
  local fb = M.current.fallback
  local notify_opts = { title = "Huez.nvim" }
  if not utils.colorscheme_exists(fb) then
    local no_fallback = string.format("Config: the fallback '%s' can't be loaded or found. Using 'default' instead", fb)
    vim.notify(no_fallback, 4, notify_opts)
    vim.cmd.colorscheme("default")
    return
  end

  local file, err = io.open(M.current.huez_theme_file, "w")
  if not file then
    vim.notify("Issue occured with Huez trying to fallback", 4, notify_opts)
    if err then
      local err_msg = string.format("Can't open huez_colorscheme for writing. Got the following error: %s", err)
      vim.notify(err_msg, 4, notify_opts)
      return
    end
    vim.notify("Unknown error attempting to open huez_colorscheme for writing.", 4, notify_opts)
    return
  end
  file:write(fb)
  file:close()
end

M.handle_theme_on_setup = function()
  local path = M.current.path
  local huez_file = M.current.huez_theme_file

  if vim.fn.isdirectory(path) == 0 then
    os.execute("mkdir " .. path)
  end

  -- if the file doesn't exist, fallback
  -- this is essentially making sure the file always exists
  local file = io.open(huez_file, "r")
  if not file then
    return fallback()
  end

  -- if what is read is nil or an emtpy string, fallback
  local colorscheme = file:read("*l")
  file:close()
  if colorscheme == nil or colorscheme == "" then
    return fallback()
  end

  -- if the colorscheme that was read can't be loaded or found, fallback
  if not utils.colorscheme_exists(colorscheme) then
    return fallback()
  end

  -- otherwise, success!
  vim.cmd.colorscheme(colorscheme)
end

return M
