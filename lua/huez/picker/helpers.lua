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

--- Set's the hl {prop} from the {group_name} to a specific {target}
---
---@param target string
---@param group_name string
---@param prop string
M.set_hl_to_target = function(target, group_name, prop)
  local rgb_value = vim.api.nvim_get_hl(0, { name = group_name })
  if rgb_value[prop] then
    local hl = string.format("#%06x", rgb_value[prop])
    vim.api.nvim_set_hl(0, target, { [prop] = hl })
  else
    -- if prop does not exist on that group_name, just return
    return
  end
end

return M
