vim.cmd([[
    if !has('gui_running')
      set t_Co=256
    endif
]])
vim.cmd('set background=dark')
vim.cmd('let base16colorspace=256')
vim.cmd('colorscheme solarized')
vim.cmd('syntax enable')
vim.cmd('hi Normal ctermbg=NONE')
