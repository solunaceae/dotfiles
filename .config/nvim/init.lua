--[[
  Standard vim options
]]

vim.opt.number = true
vim.opt.termguicolors = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.mouse = "a"
vim.opt.clipboard = "unnamed"

-- unmaps space, then remaps it to leader

vim.api.nvim_set_keymap(
  "n",
  "<SPACE>",
  "<Nop>",
  { noremap = true }
)
vim.g.mapleader = " "

-- colorscheme stuff

vim.opt.background = "dark"
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")

-- tab controls

vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- sane split controls

local paneKeys = {
  "H",
  "J",
  "K",
  "L"
}

for _, key in ipairs(paneKeys) do
  vim.api.nvim_set_keymap(
    "n",
    "<C-" .. key .. ">",
    "<C-W><C-" .. key .. ">",
    { noremap = true }
  )
end

--[[
  Lazy.nvim package manager bootstrapping and setup
]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

vim.api.nvim_set_keymap(
  "n",
  "<leader>cl",
  "<cmd>Lazy<cr>",
  { noremap = true }
)
