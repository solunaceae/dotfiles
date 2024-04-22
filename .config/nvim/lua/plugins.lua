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
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = true,
  },

  -- better nvim UIs
  'stevearc/dressing.nvim',

  -- better "problems" screen
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true,
  },

  -- Keymap reminder
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = true,
  },

  -- Database integration
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" }
  },

  -- git blame
  {
    "f-person/git-blame.nvim",
    opts = {
      enabled = false,
    },
    config = true,
  },
}
