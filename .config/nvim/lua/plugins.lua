return {
  -- makes dirs on save
  "jghauser/mkdir.nvim",

  -- notifications
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
    config = true,
  },

  -- commenting
  "tpope/vim-commentary",

  -- debugger protocol
  'mfussenegger/nvim-dap',

  -- better nvim UIs
  'stevearc/dressing.nvim',

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = true,
  },
}

