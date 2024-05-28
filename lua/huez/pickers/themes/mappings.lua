local M = {}

M.attach = function(attach_map, actions)
  attach_map("i", "<C-j>", actions.next_theme)
  attach_map("i", "<C-k>", actions.prev_theme)
  attach_map("i", "<C-n>", actions.next_theme)
  attach_map("i", "<C-p>", actions.prev_theme)
  attach_map("i", "<Up>", actions.prev_theme)
  attach_map("i", "<Down>", actions.next_theme)

  attach_map("n", "j", actions.next_theme)
  attach_map("n", "k", actions.prev_theme)
  attach_map("n", "<C-n>", actions.next_theme)
  attach_map("n", "<C-p>", actions.prev_theme)
  attach_map("n", "<esc>", actions.unload_on_quit)

  attach_map("n", "<space>", actions.add_to_favorites)
end

return M
