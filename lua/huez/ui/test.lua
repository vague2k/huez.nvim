local n = require("nui-components")
local api = require("huez.api")

-- TODO: let create_renderer to take in a function or a table of acceptable values
local renderer = n.create_renderer({
  width = 40,
  height = vim.api.nvim_win_get_height(0),
  relative = "editor",
  -- position starts from the left corner
  position = {
    row = 0,
    col = vim.api.nvim_win_get_width(0) + 3,
  },
})

local theme_nodes = api.filter_default_themes({ adapter = "nui" })

local body = n.columns(n.rows(
  { flex = 2 },
  n.prompt({
    autofocus = true,
    -- TODO: make prefix, border_label.text and border_label.align be configurable
    prefix = " ::: ",
    size = 1,
    border_label = {
      text = "󰌁 Huez",
      align = "center",
    },
  }),

  n.tree({
    flex = 1,
    autofocus = false,
    border_label = "Themes",
    data = theme_nodes,
    prepare_node = function(node, line)
      line:append(node.text)
      return line
    end,
  })
))

renderer:add_mappings({
  {
    mode = { "n" },
    from = "<leader>c",
    to = function()
      renderer:close()
    end,
  },
})

renderer:render(body)