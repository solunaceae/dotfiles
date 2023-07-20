local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd [[packadd packer.nvim]]

vim.cmd([[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- new theme who dis?
  use 'ray-x/aurora'

  -- prereq for others
  use "nvim-lua/plenary.nvim"

  -- null-ls
  use 'jose-elias-alvarez/null-ls.nvim'

  -- Mason package manager
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    run = ":MasonUpdate"
  }

  -- Coq autocompletion
  use 'ms-jpq/coq_nvim'
  use 'ms-jpq/coq.artifacts'

  -- tree-sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install')
        .update({ with_sync = true })

        ts_update()
      end
  }

  -- Filetree!
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    }
  }

  -- status bar
  use 'tamton-aquib/staline.nvim'
  require('staline').setup()

  -- makes empty dirs on save
  -- listen it's just convenient
  use 'jghauser/mkdir.nvim'

  -- notifications, for things that use them
  use 'rcarriga/nvim-notify'
  vim.notify = require('notify')
  vim.notify.setup({
    background_colour = "#000000",
  })

  -- debugger protocol
  use 'mfussenegger/nvim-dap'

  -- commenting plugin!
  use 'tpope/vim-commentary'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

