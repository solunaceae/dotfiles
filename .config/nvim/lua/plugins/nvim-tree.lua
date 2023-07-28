return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  keys = {
    {
      "<C-1>",
      "<cmd>NvimTreeToggle<cr>",
      desc = "Toggle NvimTree",
    }
  },
  lazy = false,
  config = function()
    require("nvim-tree").setup()
  end
}

