"#################
"#### Plugins ####
"#################

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'ervandew/supertab'
Plug 'altercation/vim-colors-solarized'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'lervag/vimtex'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plugin 'tpope/vim-obsession'
Plugin 'dhruvasagar/vim-prosession'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Change colorscheme to onedark
colorscheme solarized
set termguicolors

" NERDTree settings
" Close vim even if NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vimtex settings
let g:vimtex_view_method = 'skim'

" Lightline settings
set laststatus=2
let g:lightline = {
  \   'colorscheme': 'solarized',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
    \   'component': {
    \     'lineinfo': ' %3l:%-2v',
    \   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   }
  \ }
let g:lightline.separator = {
    \   'left': '', 'right': ''
  \}
let g:lightline.subseparator = {
    \   'left': '', 'right': '' 
  \}

" git-gutter settings
" Decrease update time for git-gutter
set updatetime=100


"##################
"#### Settings ####
"##################

" Enabling filetype support provides filetype-specific indenting, syntax
" highlighting, omni-completion and other useful settings.
filetype plugin indent on
syntax on

" Auto update file when changing focus
au FocusGained,BufEnter * :checktime

" show existing tab with 4 spaces width
set tabstop=4
" " when indenting with '>', use 4 spaces width
set shiftwidth=4
" " On pressing tab, insert 4 spaces
set expandtab

" Various settings
set noshowmode				" Remove mode because already have plugin (lightline) for it
set relativenumber			" Set relative line numbers
set autoindent                  	" Minimal automatic indenting for any filetype.
set backspace=indent,eol,start  	" Proper backspace behavior.
set hidden                      	" Possibility to have more than one unsaved buffers.
set incsearch                   	" Incremental search, hit '<CR>' to stop.
set ruler                       	" Shows the current line number at the bottom.  right of the screen.
set wildmenu                    	" Great command-line completion, use '<Tab>' to move around and '<CR>' to validate.
set number 				" Shows the line number for the current line only


" window settings
set scrolloff=5
set sidescrolloff=10


"##################
"#### Mappings ####
"##################

" mappings leader
let mapleader = ","
let localleader = "."

" open NERDTree
map <leader>n :NERDTreeToggle<CR>

" Toggle gitgutter
map <leader>u :GitGutterDisable<CR>:GitGutterEnable<CR>

" General Mappings
" remap esc to jk and unmap esc
inoremap jk <esc>
" remap H and L to beginning and end of line respectively
nnoremap <s-h> 0
nnoremap <s-l> $
" map for easy access .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" Copy highlighted into clipboard
vnoremap <leader>c :'<,'>w !pbcopy<cr><cr>

" Text Mappings
" map to surround word in '', "", [], (), ``
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>[ viw<esc>a]<esc>bi[<esc>lel
nnoremap <leader>] viw<esc>a]<esc>bi[<esc>lel
nnoremap <leader>( viw<esc>a)<esc>bi(<esc>lel
nnoremap <leader>) viw<esc>a)<esc>bi(<esc>lel
nnoremap <leader>` viw<esc>a`<esc>bi`<esc>lel
" set c-u capitalize word and s-u (normal only) to uppercase letter
inoremap <c-u> <esc>viwUw
nnoremap <c-u> viwUw
nnoremap <s-u> vUl
" map to delete word under cursor
nnoremap <leader>w bdw
" insert line break
nnoremap <leader>j i<cr><esc>

