local default_conf = vim.g.huez_config
local actions = {}

---@deprecated
-- This function has been deprecated
--
-- Use huez.api instead
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
