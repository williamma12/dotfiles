local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- IDE Plugings
  use 'dyng/ctrlsf.vim'                      -- Search files for search terms.
  use 'ctrlpvim/ctrlp.vim'                   -- Find and open files.
  use 'tpope/vim-commentary'                 -- Comment out lines of code.
  use 'tpope/vim-fugitive'                   -- Git support in vim.
  use 'tommcdo/vim-fugitive-blame-ext'       -- Add commit message to Gblame in vim-fugitive.
  use 'mbbill/undotree'                      -- Undo tree.
  use 'preservim/nerdtree'                   -- File explorer.
  use 'PhilRunninger/nerdtree-buffer-ops'    -- Manage buffers in file explorer.
  use {                                      -- Dynamically set tab size.
    'nmac427/guess-indent.nvim',
    config = function() require('guess-indent').setup {} end,
  }
  
  -- Language stuff
  use 'google/vim-jsonnet'         -- Jsonnet plugin.
  use {                            -- LSP that also ties in autocompletion and snippets.
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'L3MON4D3/LuaSnip'},
    }
  }
  
  -- GUI useins
  use 'itchyny/lightline.vim'                -- Bottom status bar for vim.
  use 'altercation/vim-colors-solarized'     -- Solarized support for vim.
  use 'airblade/vim-gitgutter'               -- View changed lines wrt git next to line numbers.
  use 'edkolev/tmuxline.vim'                 -- Support vim lightline with tmux.
  
  -- Session Manager useins
  use 'tpope/vim-obsession'          -- Create session with `:Obsess` (`!` to delete). 
  use 'dhruvasagar/vim-prosession'   -- Create named sessions.
  
  -- Buffer management
  use 'Asheq/close-buffers.vim'  -- Easily delete buffers.

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

  -- Load configs for plugins.
  require('plugins.lsp_zero')
end)
