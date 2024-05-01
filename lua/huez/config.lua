local log = require("huez.utils.log")
local M = {}

---@class Huez.Config.Picker.Position
---@field row number
---@field col number|nil

---@class Huez.Config.Picker
---@field preset "left"|"center"|"right"|nil
---@field width number
---@field height number|nil
---@field position Huez.Config.Picker.Position

---@class Huez.Config
---@field file_path string
---@field fallback string
---@field exclude string[]
---@field picker Huez.Config.Picker

---@type Huez.Config
local DEFAULT_SETTINGS = {
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
  -- configures how you want the theme picker to look
  picker = {
    -- if you don't wanna bother with specifics of positioning, you can always use the preset!
    -- if nil, will use width, height... etc.
    preset = "right",
    -- the dimensions of the picker itself, these defaults are the equivalent of preset "right"
    width = 40,
    height = nil, -- if nil, use the entire window height
    -- where you want to picker to render on the window, position's row and col start from the LEFT corner
    position = {
      row = 0,
      col = nil, -- if nil, use width of window + picker.width
    },
  },
}

M._DEFAULT_SETTINGS = DEFAULT_SETTINGS
M.current = M._DEFAULT_SETTINGS

---@param user_opts Huez.Config
M.set = function(user_opts)
  M.current = vim.tbl_deep_extend("force", vim.deepcopy(M.current), user_opts)
end

M.init_cache_file = function()
  -- check if the file exists for persist the theme
  local file = io.open(M.current.file_path, "r+")
  if file then
    local theme_name = file:read("*line") -- read first line
    file:close()
    -- if the theme does not exist, resort to fallback, and write fallback to file
    if theme_name then
      local ok, _ = pcall(vim.cmd.colorscheme, theme_name)
      if not ok then
        file = io.open(M.current.file_path, "w")
        if file then
          file:write(M.current.fallback)
          vim.cmd.colorscheme(M.current.fallback)
          log.notify("The theme " .. theme_name .. " does not exist, fell back to " .. M.current.fallback, "warn")
        end
        return
      end
      return
    end
  end

  -- if file doesn't exist or couldn't be read, create it with fallback theme
  file = io.open(M.current.file_path, "w")
  if file then
    file:write(M.current.fallback)
    file:close()
    vim.cmd("colorscheme " .. M.current.fallback)
    log.notify(
      "No 'huez-theme' file was found, so one was created at\n '"
        .. M.current.file_path
        .. "' with the theme '"
        .. M.current.fallback
        .. "' as a fallback.",
      "warn"
    )
  end
end
return M
