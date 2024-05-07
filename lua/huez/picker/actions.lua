local help = require("huez.picker.helpers")
local M = {}

M.prompt = {
  -- Simply change the current state of `signal.query` to whatever the current `value` of input is
  current_input = function(signal)
    return function(value)
      signal.query = value
    end
  end,

  -- Saves the colorscheme of the top matched option in the tree compared to the query
  -- I found this to be a better UX
  save_theme_on_sumbit = function(api, signal, renderer, component_id, log)
    return function()
      local component = renderer:get_component_by_id(component_id)
      if signal.query:get_value() ~= "" and #component:get_props().data > 0 then
        local top_query_match = component:get_props().data[1].name
        api.save(top_query_match)
        renderer:close()
        log.notify("Selected " .. top_query_match, "info")
      end
    end
  end,
}

M.select = {
  -- Load the current hovered node.name (colorscheme) to be previewed
  preview_theme_on_change = function(node)
    vim.cmd.colorscheme(node.name)
    help.set_hl_to_target("NuiComponentsSelectNodeFocused", "CursorLine", "bg")
  end,

  -- Picks and saves the current focused node (option) on the tree
  save_theme_on_select = function(api, renderer, log)
    return function(node)
      api.save(node.name)
      renderer:close()
      log.notify("Selected " .. node.name, "info")
    end
  end,

  -- Loads the first node.name (colorscheme) to be previewed when the component is focused
  preview_first_theme_on_focus = function(component)
    local first_theme_from_options = component:get_props().data[1].name
    vim.cmd.colorscheme(first_theme_from_options)
    help.set_hl_to_target("NuiComponentsSelectNodeFocused", "CursorLine", "bg")
  end,

  -- When exiting the select menu, revert back to the currently saved colorscheme
  unload_theme_on_unfocus = function(api)
    return function()
      vim.cmd.colorscheme(api.get())
    end
  end,

  filtered_data = function(signal)
    return signal.data:dup():combine_latest(signal.query:debounce(0):start_with(""), function(items, query)
      return vim.tbl_filter(function(item)
        return string.find(item.name:lower(), query:lower()) ~= nil
      end, items)
    end)
  end,
}

return M
