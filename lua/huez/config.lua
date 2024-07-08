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

---@param user_opts Huez.Config
M.set = function(user_opts)
  M.current = vim.tbl_deep_extend("force", vim.deepcopy(M.current), user_opts)
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

  local ok, _ = pcall(vim.cmd.colorscheme, theme)

  return ok
end

--- setup the specific files according to path,
-- currently not supporting windows cuz I'm not tryna deal with it lol
-- someone will make a PR eventually

-- REFACTOR: in DIRE need of a refactor, this shit's getting disgustingly hard to follow
M.handle_theme_on_setup = function()
  local path = M.current.path
  local huez_file = M.current.huez_theme_file
  local fallback = M.current.fallback
  local notify_opts = { title = "Huez.nvim" }
  -- check if the plugin's cache dir exists, if not create it
  if vim.fn.isdirectory(path) == 0 then
    os.execute("mkdir " .. path)
  end
  -- check if the file exists for persist the theme
  local file = io.open(huez_file, "r+")

  if file then
    local theme_name = file:read("*line") -- read first line
    file:close()

    -- if the theme does not exist, resort to fallback, and write fallback to file
    if theme_name then
      local ok = M.set_theme(theme_name)

      if not ok then
        file = io.open(huez_file, "w")

        if file then
          ok = M.set_theme(fallback)

          if not ok then
            file:write("default")
            M.set_theme("default")
            vim.notify("The theme " .. theme_name .. " does not exist, fell back to " .. fallback, 3, notify_opts)
            vim.notify("The theme " .. fallback .. " does not exist, fell back to nvim's default theme", 3, notify_opts)
            return
          end

          file:write(fallback)
          M.set_theme(fallback)
          vim.notify("The theme " .. theme_name .. " does not exist, fell back to " .. fallback, 3, notify_opts)
        end
        return
      end
      return
    end
  end

  -- if file doesn't exist or couldn't be read, create it with fallback theme
  file = io.open(huez_file, "w")
  if file then
    file:write(fallback)
    file:close()
    vim.cmd("colorscheme " .. fallback)
    vim.notify(
      "No 'huez-theme' file was found, so one was created at\n '"
        .. huez_file
        .. "' with the theme '"
        .. fallback
        .. "' as a fallback.",
      3,
      notify_opts
    )
  end
end

return M
