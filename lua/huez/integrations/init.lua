local utils = require("huez.utils")

local function pick_colorscheme()
  local picker = vim.g.huez_config.picker
  local success, _ = pcall(require, "telescope.pickers")

  if not success then
    utils._logger("Huez: telescope not installed, falling back to vim.ui.select", "ERROR")
  end

  if picker == "telescope" and success then
    return require("huez.integrations.telescope.adapter").pick_colorscheme()
  end

  require("huez.integrations.vim-ui.adapter").pick_colorscheme()
end

return {
  pick_colorscheme = pick_colorscheme,
}
