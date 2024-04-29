local M = {}

---@class Huez.Config
---@field file_path string
---@field fallback string
---@field exclude string[]

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
    if theme_name then
      vim.cmd("colorscheme " .. theme_name)
      return
    end
  end

  -- if file doesn't exist or couldn't be read, create it with fallback theme
  file = io.open(M.current.file_path, "w")
  if file then
    file:write(M.current.fallback)
    file:close()
    vim.cmd("colorscheme " .. M.current.fallback)
    vim.notify(
      "No 'huez-theme' file was found, so one was created at\n '"
        .. M.current.file_path
        .. "' with the theme '"
        .. M.current.fallback
        .. "' as a fallback.",
      vim.log.levels.WARN,
      { title = "Huez.nvim" }
    )
  end
end
return M
