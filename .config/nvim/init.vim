" sets line numbers
set number

" Sets termguicolors. Simple.
set termguicolors

" more sane split behavior
set splitright
set splitbelow

" mouse controls!
set mouse=a

" maps <leader> to space"
nnoremap <SPACE> <Nop>
let mapleader=" "

" package manager!
lua require('plugins')

" Control-1 should bring up the Nvim Tree.
nmap <C-1> :NvimTreeToggle<CR>

" Colorscheme
set background=dark
let g:aurora_transparent = 1
colorscheme aurora
hi Normal guibg=NONE ctermbg=NONE "remove background

" set a tab to be four spaces
" instead of 40 like a fucking psychopath
set shiftwidth=2
set expandtab
set autoindent
set smartindent

let g:coq_settings = { 'auto_start': 'shut-up' }
let g:coq_settings = { "keymap.jump_to_mark": "null",
                     \ "keymap.pre_select": v:true }

" more sane split controls
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Keybindings for telescope.nvim
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" allow for copying to the clipboard, you naughty goose.
set clipboard=unnamed

" Misc lua setups that function weirdly under Packer config
lua require("config.lsp")
lua require("nvim-tree").setup()

" Fixes for OCaml files being weird with the LSP
autocmd BufRead,BufNewFile *.mll set filetype=ocaml.ocamllex
autocmd BufRead,BufNewFile *.mly set filetype=ocaml.menhir

