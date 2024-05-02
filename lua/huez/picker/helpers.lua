local n = require("nui-components")
local M = {}

--- Takes in a `string[]` {themes} and converts the array `NuiTreeNode[]` where each node option with a `name` field
---
---@param themes string[]
---@return NuiTreeNode[]
M.tonodes = function(themes)
  ---@type NuiTreeNode[]
  local nodes = {}
  for _, theme in pairs(themes) do
    local node = n.option(theme, { name = theme })
    table.insert(nodes, node)
  end
  return nodes
end

--- Sets the CursorLine hl of the currently previewed colorscheme of the current focused option
---
--- The following hl group for the node being `NuiComponentsSelectNodeFocused`
M.set_cursor_line_hl = function()
  local rgb_value = vim.api.nvim_get_hl(0, { name = "CursorLine" })
  if rgb_value.bg then
    local hl = string.format("#%06x", rgb_value.bg)
    vim.api.nvim_set_hl(0, "NuiComponentsSelectNodeFocused", { bg = hl })
  else
    -- if theme does not have a cursor line highlight, just return
    return
  end
end

return M
