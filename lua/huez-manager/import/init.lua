local registry = require("huez-manager.registry")
local selected = require("huez-manager.api.selected").selected()

local return_spec = {}
for _, value in ipairs(selected) do
  local spec = {
    url = registry[value].url,
    -- FIXME: when opts is passed, lazy attempts to call setup, which not all themes have
    --
    -- opts = registry[value].opts,
    name = registry[value].pkgname,
    -- FIXME: dependencies do not install,
    --
    dependencies = registry[value].dependencies,
    event = "UiEnter",
    -- FIXME: commented out for now, but we need a way to derive a config from the colorscheme, metatables?
    --
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
