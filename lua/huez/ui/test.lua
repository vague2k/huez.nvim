local n = require("nui-components")
local api = require("huez.api")
local utils = require("huez.utils")
local config = require("huez.config")

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

local state = n.create_signal({
  input = "",
  options = api.get_installed_themes(config.current.exclude),
})

-- TODO: rewrite this func with parameters
local body = function()
  return n.columns(n.rows(
    { flex = 2 },
    n.prompt({
      id = "theme_picker_prompt",
      autofocus = true,
      prefix = " ::: ",
      value = state.input,
      size = 1,
      border_label = {
        text = "󰌁 Huez",
        align = "center",
      },
      on_change = function(curr)
        -- TODO: implement searching
        state.input = curr
      end,
    }),

    n.select({
      id = "theme_picker_options",
      flex = 1,
      autofocus = false,
      border_label = "Themes",
      data = tonode(state.options),
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
end

-- TODO: extract this to a function that returns a table of mappings
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

local function pick_colorscheme()
  renderer:render(body)
  -- local options = renderer:get_component_by_id("theme_picker_options")
  -- vim.print(options:get_props().data)
end

return {
  pick_colorscheme = pick_colorscheme,
}
