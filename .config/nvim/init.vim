" sets line numbers
set number

" Sets termguicolors. Simple.
set termguicolors

" more sane split behavior
set splitright
set splitbelow

" mouse controls!
set mouse=a

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
set tabstop=2
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

" allow for copying to the clipboard, you naughty goose.
set clipboard=unnamed

" LSP configuration
lua require('lsp')

" Tree-sitter config
lua require('ts')

" Filetree config
lua require('filetree')

" Fixes for OCaml files being weird with the LSP
autocmd BufRead,BufNewFile *.mll set filetype=ocaml.ocamllex
autocmd BufRead,BufNewFile *.mly set filetype=ocaml.menhir

" Autoupdate for packer 
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

COQnow -s 
