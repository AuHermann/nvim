local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

--local m = require('functions.keymap')

vim.g.mapleader = ' '
--m.key('n', '<Space>', '', {})

require('lazy').setup({
    { 'nvim-lua/popup.nvim' },
    { 'david-kunz/treesitter-unit' },
    { 'nvim-treesitter/nvim-treesitter' },
    { 'nvim-telescope/telescope-fzf-native.nvim',  run = 'make' },
    { 'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' }},
    { 'nvim-telescope/telescope-file-browser.nvim' },
    { 'debugloop/telescope-undo.nvim' },

    -- snippets
    { 'dcampos/nvim-snippy' },
    { 'dcampos/cmp-snippy' },
    { 'honza/vim-snippets' },
    { "L3MON4D3/LuaSnip", -- follow latest release.
	    version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	    build = "make install_jsregexp"
    },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'ray-x/cmp-treesitter' },
    { 'andersevenrud/cmp-tmux' },
    { 'hrsh7th/nvim-cmp' },

    --lsp
    { 'neovim/nvim-lsp' },
    { 'ray-x/lsp_signature.nvim' },
    { 'windwp/nvim-autopairs' },
    { 'tpope/vim-surround' },
    { 'numToStr/Comment.nvim' },
    { 'mbbill/undotree' },
    { 'aserowy/tmux.nvim' },
    { 'theprimeagen/harpoon' },
    { "williamboman/mason.nvim" },
    { 'nvim-lualine/lualine.nvim' },
    { 'Mofiqul/dracula.nvim' },

    -- git
    { 'lewis6991/gitsigns.nvim' },
    { 'sindrets/diffview.nvim' },
    { 'theprimeagen/git-worktree.nvim' },
    { 'timuntersberger/neogit' },
    { 'sindrets/diffview.nvim' },

    { 'lervag/vimtex' },
})
