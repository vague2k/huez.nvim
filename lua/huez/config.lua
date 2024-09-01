local utils = require("huez-manager.utils")
local M = {}

---@class Huez.Config
---@field path? string
---@field fallback? string
---@field exclude? string[]

---@type Huez.Config
M._DEFAULTS = {
  -- the path where huez writes/reads data to and from.
  path = vim.fs.normalize(vim.fn.stdpath("data") --[[@as string]]) .. "/huez",
  -- the fallback colorscheme to load just in case huez can't find/load your desired/persistent colorscheme.
  fallback = "default",
  -- list of colorschemes to exclude from a picker, this list contains default colorschemes that come with neovim.
  -- the default list is enough a majority of the time, but you can always change it to fit your preferences.
  exclude = {
    "blue",
    "darkblue",
    "delek",
    "desert",
    "elflord",
    "evening",
    "habamax",
    "industry",
    "koehler",
    "lunaperche",
    "morning",
    "murphy",
    "pablo",
    "peachpuff",
    "quiet",
    "ron",
    "shine",
    "slate",
    "sorbet",
    "torte",
    "vim",
    "wildcharm",
    "zaibatsu",
    "zellner",
  },
}

M.user = vim.deepcopy(M._DEFAULTS)
M.user.huez_colorscheme_file = M.user.path .. "/huez_colorscheme"

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

---@param opts Huez.Config
---@return string
M.set_user_opts = function(opts)
  M.user = vim.tbl_deep_extend("force", M.user, opts)

  local err = M.validate_user_config(M.user)
  if err ~= "" then
    return err
  end

  return ""
end

-- if falling back to a user fallback colorscheme fails, ultimately fallback to neovim's default
local fallback = function()
  local fb = M.user.fallback
  if not utils.colorscheme_exists(fb) then
    local no_fallback = string.format("Config: the fallback '%s' can't be loaded or found. Using 'default' instead", fb)
    vim.notify(no_fallback, 4, { title = "Huez.nvim" })
    vim.cmd.colorscheme("default")
    return
  end

  local file, err = io.open(M.user.huez_colorscheme_file, "w")
  if not file then
    vim.notify("Issue occured with Huez trying to fallback", 4, { title = "Huez.nvim" })
    if err then
      local err_msg = string.format("Can't open huez_colorscheme for writing. Got the following error: %s", err)
      vim.notify(err_msg, 4, { title = "Huez.nvim" })
      return
    end
    vim.notify("Unknown error attempting to open huez_colorscheme for writing.", 4, { title = "Huez.nvim" })
    return
  end
  file:write(fb)
  file:close()
end

M.handle_huez_colorscheme = function()
  local path = M.user.path
  local huez_file = M.user.huez_colorscheme_file

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
