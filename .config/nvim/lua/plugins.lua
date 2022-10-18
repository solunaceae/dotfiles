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

  -- Configurations for Nvim
  use 'neovim/nvim-lspconfig'

  -- Coq autocompletion
  use 'ms-jpq/coq_nvim'
  use 'ms-jpq/coq.artifacts'

  -- tree-sitter
  use { 
    'nvim-treesitter/nvim-treesitter',
	run = ':TSUpdate'
  }

  -- Filetree!
  use {
  'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
	}
  }
end)

