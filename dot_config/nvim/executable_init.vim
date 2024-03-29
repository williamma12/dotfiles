" mappings leader
let mapleader = ","
let localleader = "."

lua require("plugins")
lua require("colorscheme")

" Lightline 
" ---------
set laststatus=2
let g:lightline = {
  \   'colorscheme': 'solarized',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'relativepath' ],
  \              [ 'readonly', 'modified' ]
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

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" vim-jsonnet
" -----------
let g:jsonnet_fmt_on_save = 0

" Regular vim settings
" --------------------
" Let iterm handle mouse
set mouse=

" undo tree
" ---------
nnoremap <F6> :UndotreeToggle<cr>

" NerdTree
" --------
" Open NERDTree in the directory of the current file (or /home if no file is open)
nmap <silent> <C-t> :call NERDTreeToggleInCurDir()<cr>
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    exe ":NERDTreeFind"
  endif
endfunction


" chezmoi
" -------
"  Automatically update dotfiles repo when saving.
autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path %


" =============================================================================
" # Editor settings
" =============================================================================

" limit max highlight to 300 chars
set synmaxcol=300

" " On pressing tab, insert 4 spaces
set expandtab

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

" Toggle search highlighting.
nnoremap <leader>/ :noh<CR>

" Shows the current line number at the bottom.  right of the screen.
set ruler

" Great command-line completion, use '<Tab>' to move around and '<CR>' to validate.
set wildmenu

" Shows the line number for the current line only
set number

" window settings
set scrolloff=5
set sidescrolloff=10

" Permanent undo
set undodir=~/.vimdid
set undofile

" =============================================================================
" # Keyboard shortcuts
" =============================================================================

" ; as :
nnoremap ; :

" Ctrl+j and Ctrl+k as Esc
" Ctrl-j is a little awkward unfortunately:
" https://github.com/neovim/neovim/issues/5916
" So we also map Ctrl+k
nnoremap <C-j> <Esc>
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
snoremap <C-j> <Esc>
xnoremap <C-j> <Esc>
cnoremap <C-j> <C-c>
onoremap <C-j> <Esc>
lnoremap <C-j> <Esc>
tnoremap <C-j> <Esc>

nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
snoremap <C-k> <Esc>
xnoremap <C-k> <Esc>
cnoremap <C-k> <C-c>
onoremap <C-k> <Esc>
lnoremap <C-k> <Esc>
tnoremap <C-k> <Esc>

" Toggle gitgutter
map <leader>u :GitGutterDisable<CR>:GitGutterEnable<CR>

" map for easy access .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>
" Copy highlighted into clipboard
vnoremap <leader>c :'<,'>w !pbcopy<cr><cr>

" Text Mappings
" map to surround word in '', "", [], (), ``, <>
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>[ viw<esc>a]<esc>bi[<esc>lel
nnoremap <leader>] viw<esc>a]<esc>bi[<esc>lel
nnoremap <leader>( viw<esc>a)<esc>bi(<esc>lel
nnoremap <leader>) viw<esc>a)<esc>bi(<esc>lel
nnoremap <leader>` viw<esc>a`<esc>bi`<esc>lel
nnoremap <leader>< viw<esc>a><esc>bi<<esc>lel
nnoremap <leader>> viw<esc>a><esc>bi<<esc>lel
nnoremap <leader>{ viw<esc>a}<esc>bi{<esc>lel
nnoremap <leader>} viw<esc>a}<esc>bi{<esc>lel
" set c-u capitalize word and s-u (normal only) to uppercase letter
inoremap <c-u> <esc>viwUw
" nnoremap <c-u> viwUw
nnoremap <s-u> vUl
" map to delete word under cursor
nnoremap <leader>w bdw
" insert line break
nnoremap <leader>j i<cr><esc>
" Move tabs left and right
noremap <Leader><Left>  :tabmove -1<CR>
noremap <Leader><Right> :tabmove +1<CR>
" Jump to beginning/end of line
noremap <s-h> 0
noremap <s-l> $

" =============================================================================
" # Autocommands
" =============================================================================

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
