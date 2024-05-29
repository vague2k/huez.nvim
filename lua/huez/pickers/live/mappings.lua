local M = {}

M.attach = function(attach_map, actions)
  -- TODO: create usercmd to unload live themes, otherwise, unload on vim exit instead of when we leave the picker

  attach_map("i", "<C-j>", actions.optimistic_preview_next)
  attach_map("i", "<C-k>", actions.optimistic_preview_prev)
  attach_map("i", "<C-n>", actions.optimistic_preview_next)
  attach_map("i", "<C-p>", actions.optimistic_preview_prev)
  attach_map("i", "<Up>", actions.optimistic_preview_prev)
  attach_map("i", "<Down>", actions.optimistic_preview_next)

  attach_map("n", "j", actions.optimistic_preview_next)
  attach_map("n", "k", actions.optimistic_preview_prev)
  attach_map("n", "<C-n>", actions.optimistic_preview_next)
  attach_map("n", "<C-p>", actions.optimistic_preview_prev)
  attach_map("n", "<esc>", actions.unload_live_themes)

  attach_map("n", "<space>", actions.add_to_ensured)
end

return M
