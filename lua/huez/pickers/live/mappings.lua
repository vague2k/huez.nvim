local M = {}

M.attach = function(attach_map, actions)
  attach_map("n", "j", actions.optimistic_preview_next)
  attach_map("n", "k", actions.optimistic_preview_prev)
end

return M
