local log = require("huez-manager.utils.log")
local M = {}

---@alias Huez.Config.PickerLayout "left"|"top"|"right"|"bottom"|nil

---@class Huez.Config.PickersOpts
---@field layout Huez.Config.PickerLayout
---@field opts table

---@class Huez.Config.Pickers
---@field themes Huez.Config.PickersOpts
---@field live Huez.Config.PickersOpts
---@field ensured Huez.Config.PickersOpts

---@class Huez.Config
---@field path string
---@field fallback string
---@field exclude string[]
---@field picker Huez.Config.Pickers

---@type Huez.Config
-- TODO: write a config validator
local DEFAULT_SETTINGS = {
  -- the directory where huez place it's files to save the theme, or get current theme, things like that
  path = vim.fs.normalize(vim.fn.stdpath("data") --[[@as string]]) .. "/huez",
  -- the fallback theme which will be written to a new "huez-theme" file in case the "huez-theme" file does not exist
  fallback = "default",
  -- a list of ugly theme that come with neovim that you probably don't want to choose from in the picker
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

  -- configures how you want a certain picker to look.
  picker = {
    -- all pickers use telescope values, by default picker is anchored to the right.
    -- predefines layout ptions are "left", "top", "right", or "bottom" or nil
    -- if layout is nil, the opts field for this specific picker will be the only thing that will be used
    -- if you are using a predefined layout, any options you pass into the picker will be deep merged.
    themes = {
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
---@class Huez.Config
M.current = M._DEFAULT_SETTINGS

---@param user_opts Huez.Config
M.set = function(user_opts)
  M.current = vim.tbl_deep_extend("force", vim.deepcopy(M.current), user_opts)
end

--- setup the specific files according to path,
-- currently not supporting windows cuz I'm not tryna deal with it lol
-- someone will make a PR eventually

M.current.huez_theme_file = M.current.path .. "/huez-theme" -- If you're seeing this note, this value exists

-- REFACTOR: in DIRE need of a refactor, this shit's getting disgustingly hard to follow
M.init_cache_file = function()
  -- check if the plugin's cache dir exists, if not create it
  if vim.fn.isdirectory(M.current.path) == 0 then
    os.execute("mkdir " .. M.current.path)
  end
  -- check if the file exists for persist the theme
  local file = io.open(M.current.huez_theme_file, "r+")
  if file then
    local theme_name = file:read("*line") -- read first line
    file:close()
    -- if the theme does not exist, resort to fallback, and write fallback to file
    if theme_name then
      local ok, _ = pcall(vim.cmd.colorscheme, theme_name)
      if not ok then
        file = io.open(M.current.huez_theme_file, "w")
        if file then
          file:write(M.current.fallback)
          -- FIXME: edge case where fallback colorscheme may or may not exist
          vim.cmd.colorscheme(M.current.fallback)
          log.notify("The theme " .. theme_name .. " does not exist, fell back to " .. M.current.fallback, "warn")
        end
        return
      end
      return
    end
  end

  -- if file doesn't exist or couldn't be read, create it with fallback theme
  file = io.open(M.current.huez_theme_file, "w")
  if file then
    file:write(M.current.fallback)
    file:close()
    vim.cmd("colorscheme " .. M.current.fallback)
    log.notify(
      "No 'huez-theme' file was found, so one was created at\n '"
        .. M.current.huez_theme_file
        .. "' with the theme '"
        .. M.current.fallback
        .. "' as a fallback.",
      "warn"
    )
  end
end

return M
