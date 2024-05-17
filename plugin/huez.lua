if vim.fn.has("nvim-0.7.0") == 0 then
  vim.api.nvim_err_writeln("Huez requires at least nvim-0.7.0.1")
  return
end

-- make sure this file is loaded only once
if vim.g.loaded_huez == 1 then
  return
end
vim.g.loaded_huez = 1

require("huez").setup()
local integrations = require("huez.integrations")

vim.api.nvim_create_user_command("Huez", integrations.pick_colorscheme, {})

vim.g.huez_version = "0.2.4"
