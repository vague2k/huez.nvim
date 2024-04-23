local n = require("nui-components")

local config = vim.g.huez_config
local persist = require("huez.persist")
local utils = require("huez.utils")
local api = {}

---@class Huez.Api.Opts
---@field adapter "vimui"|"nui" Determines what array to return based on the passed adapter. default = "vimui". see |filter_default_themes()|

---@return string
-- gets the persisted colorscheme according to .huez.nvim.lua file, or vim.g.huez_colorscheme
api.get_colorscheme = function()
  local file, err = io.open(config.file_path, "r")

  if not file then
    return "", utils.log_error("Huez: Error reading file: " .. err)
  end

  local line = file:read()
  file:close()

  return line
end

---@param opts? Huez.Api.Opts
---@return table
-- Returns an array of all themes, except any omitted themes according to the Huez config
api.filter_default_themes = function(opts)
  if opts == nil then
    opts = { adapter = "vimui" }
  end

  vim.validate({
    adapter = { opts.adapter, "s" },
  })

  local default_themes = vim.g.huez_config.omit
  local all_installed_themes = vim.fn.getcompletion("", "color", true)
  local default_omitted = {}

  if opts.adapter == "nui" then
    for _, themes in ipairs(all_installed_themes) do
      if not vim.tbl_contains(default_themes, themes) then
        local theme_node = n.node
        table.insert(default_omitted, theme_node({ text = themes }))
      end
    end

    return default_omitted
  end

  -- not passing opts is optional, default to returning array that fits "vimui" or "telescope" pickers
  for _, themes in ipairs(all_installed_themes) do
    if not vim.tbl_contains(default_themes, themes) then
      table.insert(default_omitted, themes)
    end
  end

  return default_omitted
end

---@param colorscheme string
-- saves colorscheme to the file specific in the config's file_path
api.save_colorscheme = function(colorscheme)
  vim.cmd("hi clear")
  vim.cmd("syntax reset")
  vim.cmd("colorscheme " .. colorscheme)
  persist._write_theme_to_file(colorscheme)
end

return api
