local avail = require("huez.api.available")

-- TODO:
-- 1. Select should come from user defined file
--
-- WIP: For live preview, we can do 1 of 2 things,
-- 1. clone the entire registry in a non-blocking/async manner into |vim.fn.stdpath("cache")|,
-- and do this chronologically based on available options so user can instantly start previewing themes from the registry,
-- 2. When the initial UI is rendered, clone the first 5-10 (idk yet) themes and try to optimistically clone more themes as
-- the user navigates the registry menu.

local return_spec = {}
local selected = { "tokyonight", "nightfox" }
for _, value in ipairs(selected) do
  local spec = {
    url = avail.lib[value].url,
    opts = avail.lib[value].opts,
  }
  table.insert(return_spec, spec)
end

return return_spec
