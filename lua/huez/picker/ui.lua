local n = require("nui-components")
local fn = require("nui-components.utils.fn")
local colorscheme = require("huez.api").colorscheme
local log = require("huez.utils.log")
local helpers = require("huez.utils.helpers")

local actions = require("huez.picker.actions")

local SELECT_ID = "theme_picker_options"
local PROMPT_ID = "theme_picker_prompt"

local test_conf = require("huez.picker.renderer")

-- FIXME: why does select component randomly render different amount of options on each neovim instance
local renderer = n.create_renderer(test_conf._calc_pos())

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

local theme_picker = function()
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
      on_change = actions.prompt.current_input(signal),
      on_submit = actions.prompt.save_theme_on_sumbit(colorscheme, signal, renderer, SELECT_ID, log),
    }),

    n.select({
      id = SELECT_ID,
      flex = 1,
      autofocus = false,
      border_label = "Themes",
      data = get_data(),
      on_change = actions.select.preview_theme_on_change,
      on_select = actions.select.save_theme_on_select(colorscheme, renderer, log),
      on_focus = actions.select.preview_first_theme_on_focus,
      on_blur = actions.select.unload_theme_on_unfocus(colorscheme),
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
  signal.query = "" -- clears the query state
end)

-- TODO: move this to a "builtin" dir similiar to telescope
local function pick_colorscheme()
  renderer:render(theme_picker)
end

return {
  pick_colorscheme = pick_colorscheme,
}
