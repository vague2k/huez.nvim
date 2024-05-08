local R

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
