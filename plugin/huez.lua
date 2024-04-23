if vim.fn.has("nvim-0.8.0") == 0 then
  vim.api.nvim_err_writeln("Huez requires at least nvim-0.8.0")
  return
end

-- make sure this file is loaded only once
if vim.g.loaded_huez == 1 then
  return
end
vim.g.loaded_huez = 1

require("huez").setup()
local test = require("huez.ui.test")

vim.api.nvim_create_user_command("Huez", test.pick_colorscheme, {})

vim.g.huez_version = "0.2.2"
