local R

--[[ 

This file is a registry of colorschemes, which follow the `Lazy.nvim` plugin spec. 
If you wish to add a colorscheme, the new entry must follow the spec of...

["colorscheme-name"] = {
  url = "full-github-url-of-colorscheme"
  opts = {}
  pkgname = "name-of-standalone-repo"
}

]]

---@class ThemeRegistryEntry
---@field url string
---@field opts table
---@field pkgname string

---@type table<string, ThemeRegistryEntry>
R = {
  ["tokyonight"] = {
    url = "https://github.com/folke/tokyonight.nvim",
    opts = {},
    pkgname = "tokyonight.nvim",
  },
  ["nightfox"] = {
    url = "https://github.com/EdenEast/nightfox.nvim",
    opts = {},
    pkgname = "nightfox.nvim",
  },
}

return R
