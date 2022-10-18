unlet! skip_defaults_vim 
source $VIMRUNTIME/defaults.vim

"sets line numbers
set number

"more sane split behavior
set splitright
set splitbelow

"more sane split controls
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"set a tab to be four spaces
"instead of 40 like a fucking psychopath
set shiftwidth=2
set tabstop=2
set autoindent
set smartindent

"allow for copying to the clipboard, you naughty goose.
set clipboard=unnamed
