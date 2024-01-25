local config = {}

config.default_config = {
  file_path = vim.fs.normalize(vim.fn.stdpath("config")) .. "/.nvim.huez.lua",
  fallback = "default",
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
  picker_opts = require("telescope.themes").get_dropdown({}),
}

return config
