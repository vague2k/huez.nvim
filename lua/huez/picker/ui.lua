local n = require("nui-components")
local colorscheme = require("huez.api").colorscheme
local log = require("huez.utils.log")
local helpers = require("huez.picker.helpers")
local actions = require("huez.picker.actions")

local SELECT_ID = "theme_picker_options"
local PROMPT_ID = "theme_picker_prompt"

local renderer_position = require("huez.picker.renderer")
local renderer = n.create_renderer(renderer_position.calc_pos())

-- TODO:
-- requirements for the "favorites picker"
-- 1. theme_picker should have a "tag" mode that when enabled, changes the label of the prompt and select
--    aswell as call notify to indicate the user has switched picker modes
-- 2. an icon should be appened to the node line. i.e. ("-> current_focused_theme_name")
-- 3. the `save_theme_on_select()` method should be the only thing that changes, when switching modes.
-- 4. the component tree in "tag" mode has to be callable from a user cmd, as "HuezFavoritesAdd".
--
-- NOTE: would creating a custom component solve the issues above? see nui-components docs.

local signal = n.create_signal({
  query = "",
  data = helpers.tonodes(colorscheme.installed()),
})

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
      data = actions.select.filtered_data(signal),
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
