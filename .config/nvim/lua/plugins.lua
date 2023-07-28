return {
  -- status line
  {
    'tamton-aquib/staline.nvim',
    config = function()
      require("staline").setup()
    end
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
}
