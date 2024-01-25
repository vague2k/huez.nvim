local config = {}

config.get_home_path = function()
  local home = ""

  local is_mac = vim.loop.os_uname().sysname == "Darwin"
  local is_linux = vim.loop.os_uname().sysname == "Darwin"
  local is_windows = vim.loop.os_uname().sysname:find("Windows") and true or false

  if is_mac or is_linux then
    home = os.getenv("HOME") or ""
  elseif is_windows then
    home = os.getenv("USERPROFILE") or ""
  end

  return home
end

config.default_config = {
  file_path = config.get_home_path() .. "/.nvim.huez.lua",
  fallback = "default",
  omit = {
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
  picker_opts = require("telescope.themes").get_dropdown({}),
}

return config
