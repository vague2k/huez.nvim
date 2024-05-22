local actions = require("huez.pickers.live.actions")
local picker_utils = require("huez.pickers.utils")
local mappings = require("huez.pickers.live.mappings")

local function render()
  local pkgs = actions.get_pkgs()

  picker_utils.picker_builder({
    picker = "live",
    prompt_title = "Huez | Registry",
    finder = {
      results = pkgs,
      ---@param entry ThemeRegistryEntry
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.pkgname,
          ordinal = entry.pkgname,
        }
      end,
    },
    mappings = function(map)
      mappings.attach(map, actions)
    end,
  })
end

return {
  render = render,
}
