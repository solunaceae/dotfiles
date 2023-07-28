return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    requires = { { 'nvim-lua/plenary.nvim' } },
    keys = {
      {
        "<leader>ff",
        "<cmd>Telescope find_files<cr>",
        desc = "Open file finder"
      },
      {
        "<leader>fg",
        "<cmd>Telescope live_grep<cr>",
        desc = "Open live grep"
      },
      {
        "<leader>fb",
        "<cmd>Telescope buffers<cr>",
        desc = "Open buffer search"
      },
      {
        "<leader>fh",
        "<cmd>Telescope help_tags<cr>",
        desc = "Open help tags"
      },
    },
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
