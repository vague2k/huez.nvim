local M = {}

M.attach = function(attach_map, actions)
  attach_map("i", "<esc>", actions.unload_live_themes)

  attach_map("n", "j", actions.optimistic_preview_next)
  attach_map("n", "k", actions.optimistic_preview_prev)
  attach_map("n", "<esc>", actions.unload_live_themes)
end

return M
