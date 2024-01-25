local default_conf = require("huez.config").default_config

local persist = {}

---checks if file_path from config exists. If it does exists, It will do nothing with it and return true
--
---If it does NOT exist, it will return false and create it
persist.check_if_file_exists = function()
  local file = io.open(default_conf.file_path, "r")
  if file then
    io.close(file)
    return
  else
    local new_file = io.open(default_conf.file_path, "w")
    if new_file then
      io.close(new_file)
      return
    end
  end
end

---@param colorscheme string
persist._write_theme_to_file = function(colorscheme)
  vim.loop.fs_open(default_conf.file_path, "w", 432, function(_, fd)
    if fd ~= nil then
      local string_to_write = '"' .. colorscheme .. '"'
      vim.loop.fs_write(fd, string_to_write, nil, function()
        vim.loop.fs_close(fd)
      end)
    else
      print(_)
    end
  end)
end

return persist
