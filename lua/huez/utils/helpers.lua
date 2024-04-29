local n = require("nui-components")
local M = {}

--- Takes in a `string[]` {themes} and converts the array `NuiTreeNode[]` where each node with a `name` field
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

return M
