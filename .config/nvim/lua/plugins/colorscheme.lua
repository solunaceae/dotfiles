return {
  'ray-x/aurora',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.aurora_transparent = 1
    vim.cmd([[colorscheme aurora]])
  end,
}
