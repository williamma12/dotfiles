" mappings leader
let mapleader = ","
let localleader = "."

" =============================================================================
" # PLUGINS
" =============================================================================

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" IDE Plugings
Plug 'dyng/ctrlsf.vim'                      " Search files for search terms.
Plug 'ctrlpvim/ctrlp.vim'                   " Find and open files.
Plug 'tpope/vim-commentary'                 " Comment out lines of code.
Plug 'tpope/vim-fugitive'                   " Git support in vim.
Plug 'tommcdo/vim-fugitive-blame-ext'       " Add commit message to Gblame in vim-fugitive.
Plug 'mbbill/undotree'                      " Undo tree.
Plug 'preservim/tagbar'                     " Tag bar for viewing tags.
Plug 'ludovicchabant/vim-gutentags'         " Ctags manager.
Plug 'preservim/nerdtree'                   " File explorer.
Plug 'PhilRunninger/nerdtree-buffer-ops'    " Manage buffers in file explorer.

" Language stuff
Plug 'rust-lang/rust.vim'                           " Rust specific plugin.
Plug 'google/vim-jsonnet'                           " Jsonnet plugin.
Plug 'derekwyatt/vim-scala'                         " Scala plugin.
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " Language server

" GUI Plugins
Plug 'itchyny/lightline.vim'                " Bottom status bar for vim.
Plug 'altercation/vim-colors-solarized'     " Solarized support for vim.
Plug 'airblade/vim-gitgutter'               " View changed lines wrt git next to line numbers.
Plug 'edkolev/tmuxline.vim'                 " Support vim lightline with tmux.

" Session Manager Plugins
Plug 'tpope/vim-obsession'          " Create session with `:Obsess` (`!` to delete). 
Plug 'dhruvasagar/vim-prosession'   " Create named sessions.

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
end

" deal with colors
if !has('gui_running')
  set t_Co=256
endif
set background=dark
let base16colorspace=256
colorscheme solarized
syntax enable
hi Normal ctermbg=NONE

" CtrlP
" -----
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_extensions = ['mixed', 'tag']
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = 'find %s -type f' 
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc
let g:ctrlp_buffer_func = { 'enter': 'CtrlPMappings' }

" Delete buffer using <C-@> in CtrlP
function! CtrlPMappings()
      nnoremap <buffer> <silent> <C-@> :call <sid>DeleteBuffer()<cr>
  endfunction

  function! s:DeleteBuffer()
        let path = fnamemodify(getline('.')[2:], ':p')
          let bufn = matchstr(path, '\v\d+\ze\*No Name')
            exec "bd" bufn ==# "" ? path : bufn
              exec "norm \<F5>"
          endfunction

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc|swp)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|venv*)$',
  \ 'file': '\v\.(exe|so|dll|pyc|swp)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Lightline 
" ---------
set laststatus=2
let g:lightline = {
  \   'colorscheme': 'solarized',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'relativepath' ],
  \              [ 'cocstatus', 'readonly', 'modified' ]
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

" CtrlSF 
" ------
let g:ctrlsf_backend = 'rg'
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

" ctags
" -----
autocmd BufRead *.rs :setlocal tags=./.rusty-tags.vi;/
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
let g:gutentags_add_default_project_roots = 0 
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_generate_on_new = 1 
let g:gutentags_generate_on_missing = 1 
let g:gutentags_generate_on_write = 1 
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

" tagbar
" ------
nmap <F8> :TagbarToggle<CR>

" coc
" ---
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Global extensions
let g:coc_global_extensions = ['coc-rust-analyzer']

" Give more space for displaying messages.
set cmdheight=2" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" undo tree
" ---------
nnoremap <F5> :UndotreeToggle<cr>

" rust
" ----
nnoremap <leader>l :RustFmt<CR>

" NerdTree
" --------
nnoremap <C-t> :NERDTreeToggle<CR>

" chezmoi
" -------
"  Automatically update dotfiles repo when saving.
autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path %


" =============================================================================
" # Editor settings
" =============================================================================

" Enabling filetype support provides filetype-specific indenting, syntax
" highlighting, omni-completion and other useful settings.
filetype plugin indent on
syntax on
set synmaxcol=300

" show existing tab with 4 spaces width
set tabstop=4

" " when indenting with '>', use 4 spaces width
set shiftwidth=4

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
