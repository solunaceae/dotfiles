return {
  -- status line
  {
    'tamton-aquib/staline.nvim',
    config = function()
      require("staline").setup()
    end
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
  },

  -- makes dirs on save
  "jghauser/mkdir.nvim",

  -- notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#000000",
      })
    end
  },

  -- commenting
  "tpope/vim-commentary",

  -- telescope/fuzzy finding
  -- debugger protocol
  'mfussenegger/nvim-dap',

  {
    'jay-babu/mason-null-ls.nvim',
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
          handlers = {},
      })
    end
  },
 
}
