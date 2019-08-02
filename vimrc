"#################
"#### Plugins ####
"#################

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" IDE Plugings
Plug 'dyng/ctrlsf.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ervandew/supertab'
Plug 'lervag/vimtex'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

" GUI Plugins
Plug 'itchyny/lightline.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'airblade/vim-gitgutter'
Plug 'edkolev/tmuxline.vim'

" Session Manager Plugins
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Change colorscheme to onedark
colorscheme solarized
set termguicolors

" vimtex settings
let g:vimtex_view_method = 'skim'

" CtrlP Settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_extensions = ['mixed', 'tag']
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = 'find %s -type f' 
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc|swp)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|venv*)$',
  \ 'file': '\v\.(exe|so|dll|pyc|swp)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" Lightline settings
set laststatus=2
let g:lightline = {
  \   'colorscheme': 'solarized',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'relativepath', 'modified' ]
  \     ],
  \     'right': [ [ 'lineinfo' ],
  \                [ 'percent' ] ]
  \   },
  \   'inactive': {
  \     'left': [ [ 'relativepath', 'modified' ] ],
  \     'right': [ [ 'lineinfo' ],
  \                [ 'percent' ] ] 
  \   },
  \   'component': {
  \     'lineinfo': ' %3l:%-2v',
  \   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   },
  \   'separator': { 'left': '', 'right': '' },
  \   'subseparator': { 'left': '', 'right': '' },
  \ }

" git-gutter settings
" Decrease update time for git-gutter
set updatetime=50

" ctrl.vim settings
set runtimepath^=~/.vim/bundle/ctrlp.vim


"##################
"#### Settings ####
"##################

" Enabling filetype support provides filetype-specific indenting, syntax
" highlighting, omni-completion and other useful settings.
filetype plugin indent on
syntax on
set synmaxcol=300

" Triger `autoread` when files changes on disk
" "
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" "
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if expand('%') !=# '[Command Line]' | checktime | endif
" " Notification after file change
" " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Auto save when leaving
au FocusLost,WinLeave * :silent! w

" show existing tab with 4 spaces width
set tabstop=4
" " when indenting with '>', use 4 spaces width
set shiftwidth=4
" " On pressing tab, insert 4 spaces
set expandtab

" Various settings
" Remove mode because already have plugin (lightline) for it
set noshowmode
" Set relative line numbers
set relativenumber
" Minimal automatic indenting for any filetype.
set autoindent
" Proper backspace behavior
set backspace=indent,eol,start
" Possibility to have more than one unsaved buffers.
set hidden
" Incremental search, hit '<CR>' to stop.
set incsearch
" Shows the current line number at the bottom.  right of the screen.
set ruler
" Great command-line completion, use '<Tab>' to move around and '<CR>' to validate.
set wildmenu
" Shows the line number for the current line only
set number

" window settings
set scrolloff=5
set sidescrolloff=10


"##################
"#### Mappings ####
"##################

" mappings leader
let mapleader = ","
let localleader = "."

" Toggle gitgutter
map <leader>u :GitGutterDisable<CR>:GitGutterEnable<CR>

" General Mappings
" remap esc to jk and unmap esc
inoremap jk <esc>
" remap H and L to beginning and end of line respectively
nnoremap <s-h> 0
nnoremap <s-l> $
vnoremap <s-h> 0
vnoremap <s-l> $
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
" inoremap <c-u> <esc>viwUw
" nnoremap <c-u> viwUw
nnoremap <s-u> vUl
" map to delete word under cursor
nnoremap <leader>w bdw
" insert line break
nnoremap <leader>j i<cr><esc>
" Move tabs left and right
noremap <Leader><Left>  :tabmove -1<CR>
noremap <Leader><Right> :tabmove +1<CR>
