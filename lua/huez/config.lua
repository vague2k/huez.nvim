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
M.setup_user_config = function(user_opts)
  M.current = vim.tbl_deep_extend("force", vim.deepcopy(M.current), user_opts)
end

return M
