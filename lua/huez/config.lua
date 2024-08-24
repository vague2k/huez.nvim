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
    M.user = M._DEFAULTS
    return err
  end

  return ""
end

M.handle_theme = function() end

return M
