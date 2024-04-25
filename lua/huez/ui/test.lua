local n = require("nui-components")
local api = require("huez.api")
local utils = require("huez.utils")

local function tonode(themes)
  local nodes = {}
  for _, theme in pairs(themes) do
    local node = n.option(theme, { name = theme })
    table.insert(nodes, node)
  end
  return nodes
end

-- TODO: let create_renderer to take in a function or a table of acceptable values
local renderer = n.create_renderer({
  width = 40,
  height = vim.api.nvim_win_get_height(0),
  relative = "editor",
  -- position starts from the left corner
  position = {
    row = 0,
    col = vim.api.nvim_win_get_width(0) - 3,
  },
})

local body = n.columns(n.rows(
  { flex = 2 },
  n.prompt({
    autofocus = true,
    prefix = " ::: ",
    size = 1,
    border_label = {
      text = "󰌁 Huez",
      align = "center",
    },
  }),

  n.select({
    flex = 1,
    autofocus = false,
    border_label = "Themes",
    data = tonode(api.get_installed_themes(vim.g.huez_config.exclude)),
    on_change = function(theme)
      vim.cmd("colorscheme " .. theme.name)
    end,
    on_select = function(theme)
      api.save_colorscheme(theme.name)
      renderer:close()
      utils.log_info("Selected " .. theme.name)
    end,
  })
))

renderer:add_mappings({
  {
    mode = "n",
    key = "q",
    handler = function()
      renderer:close()
    end,
  },
})

renderer:on_unmount(function()
  vim.cmd("colorscheme " .. api.get_colorscheme())
end)

-- FIXME: how can i get this to a usercommand without making it bug out
renderer:render(body)

-- local function pick_colorscheme()
--   renderer:render(body)
-- end
--
-- return {
--   pick_colorscheme = pick_colorscheme,
-- }
