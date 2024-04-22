local keymap = require("keymap")

return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  keys = keymap.NVIM_TREE,
  lazy = false,
  config = true,
}
