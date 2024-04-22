local _aurora = 'ray-x/aurora'
local _aurora_opts = {}
local _aurora_config = function()
  vim.g.aurora_transparent = 1
  vim.cmd.colorscheme "aurora"
end

local _tokyonight = 'folke/tokyonight.nvim'
local _tokyonight_opts = {
  style = "moon",
  styles = {
    sidebars = "transparent",
  },
  transparent = true,
  terminal_colors = true,
}
local _tokyonight_config = function(_, opts)
  require("tokyonight").setup(opts)

  vim.cmd.colorscheme "tokyonight"
end

local tokyonight = {
  _tokyonight,
  lazy = false,
  priority = 1000,
  opts = _tokyonight_opts,
  config = _tokyonight_config,
}

local aurora = {
  _aurora,
  lazy = false,
  priority = 1000,
  opts = _aurora_opts,
  config = _aurora_config,
}

return aurora
