local api = require("huez.api")
local utils = require("huez.utils")
local function pick_colorscheme(opts)
  opts = opts or {}

  local themes = api.filter_default_themes()
  vim.ui.select(themes, {
    prompt = "Huez",
  }, function(colorscheme)
    if not colorscheme then
      utils.log_error("Huez: must choose valid colorscheme")
    else
      api.save_colorscheme(colorscheme)
    end
  end)
end

return {
  pick_colorscheme = pick_colorscheme,
}
