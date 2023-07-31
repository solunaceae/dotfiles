return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = function()
      local ts_update = require("nvim-treesitter.install")
          .update({ with_sync = true })

      ts_update()
    end,
    opts = {
      ensure_installed = {},
      sync_install = true,
      auto_install = true,
      highlight = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}

