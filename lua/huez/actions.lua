local default_conf = vim.g.huez_config
local actions = {}

-- WARN: This will be deprecated in 0.2.1 or next semi-major version. Whichever comes first
-- PLEASE use require("huez.api").get_colorscheme() in your Huez configuration in your neovim config instead

actions.get_colorscheme = function()
  local file, err = io.open(default_conf.file_path, "r")

  if not file then
    return nil, print("Error reading file: ", err)
  end

  local line = file:read()
  file:close()

  return line
end

return actions
