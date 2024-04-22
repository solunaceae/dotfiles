local keymap = require("keymap")

return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = keymap.TELESCOPE,
  },

  {
    'nvim-telescope/telescope-fzy-native.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      local telescope = require("telescope")

      telescope.setup()
      telescope.load_extension("fzy_native")
    end,
  },
}
