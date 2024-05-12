local registry = require("huez_manager.registry")
local selected = require("huez_manager.selected").selected()

-- TODO:
-- 1. Select should come from user defined file
--
-- WIP: For live preview, we can do 1 of 2 things,
-- 1. clone the entire registry in a non-blocking/async manner into |vim.fn.stdpath("cache")|,
-- and do this chronologically based on available options so user can instantly start previewing themes from the
-- registry,
-- 2. When the initial UI is rendered, clone the first 5-10 (idk yet) themes and try to optimistically clone more themes
-- as the user navigates the registry menu.

local return_spec = {}
for _, value in ipairs(selected) do
  local spec = {
    url = registry[value].url,
    opts = registry[value].opts,
    name = registry[value].pkgname,
    dependencies = registry[value].dependencies,
    event = "UiEnter",
    -- config = function()
    --   local ok, _ = pcall(require(registry[value].pkgname).setup())
    --   if not ok then
    --     return
    --   end
    -- end,
  }
  table.insert(return_spec, spec)
end

return return_spec
