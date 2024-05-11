local M = {}

M.attach = function(attach_map, actions)
  attach_map("n", "j", actions.optimistic_preview_next)
end

return M
