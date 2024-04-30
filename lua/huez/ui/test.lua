local n = require("nui-components")
local fn = require("nui-components.utils.fn")
local colorscheme = require("huez.api").colorscheme
local log = require("huez.utils.log")
local helpers = require("huez.utils.helpers")

local SELECT_ID = "theme_picker_options"
local PROMPT_ID = "theme_picker_prompt"

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

local signal = n.create_signal({
  query = "",
  data = helpers.tonodes(colorscheme.installed()),
})

local get_data = function()
  return signal.data:dup():combine_latest(signal.query:debounce(0):start_with(""), function(items, query)
    return fn.ifilter(items, function(item)
      return string.find(item.name:lower(), query:lower())
    end)
  end)
end

local body = function()
  return n.columns(n.rows(
    -- { flex = 1 },
    n.prompt({
      id = PROMPT_ID,
      autofocus = true,
      prefix = " ::: ",
      value = signal.query,
      size = 1,
      border_label = {
        text = "󰌁 Huez",
        align = "center",
      },
      on_change = function(curr)
        signal.query = curr
      end,
      on_submit = function()
        if signal.query:get_value() ~= "" then
          local top_query_match = renderer:get_component_by_id(SELECT_ID):get_props().data[1].name
          colorscheme.save(top_query_match)
          renderer:close()
          log.notify("Selected " .. top_query_match, "info")
        end
      end,
    }),

    n.select({
      id = SELECT_ID,
      flex = 1,
      autofocus = false,
      border_label = "Themes",
      data = get_data(),
      on_change = function(theme)
        vim.cmd("colorscheme " .. theme.name)
      end,
      on_select = function(theme)
        colorscheme.save(theme.name)
        renderer:close()
        log.notify("Selected " .. theme.name, "info")
      end,
      on_focus = function(self)
        local first_theme_from_options = self:get_props().data[1].name
        vim.cmd("colorscheme " .. first_theme_from_options)
      end,
      on_blur = function()
        vim.cmd("colorscheme " .. colorscheme.get())
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
  vim.cmd("colorscheme " .. colorscheme.get())
end)

local function pick_colorscheme()
  renderer:render(body)
end

return {
  pick_colorscheme = pick_colorscheme,
}
