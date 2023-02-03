local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "folke/which-key.nvim",
    -- { "folke/neoconf.nvim", cmd = "Neoconf" },
    -- "folke/neodev.nvim",

    -- Color Scheme
    'rebelot/kanagawa.nvim';
    'sainnhe/sonokai';
    'sainnhe/gruvbox-material';
    'ellisonleao/gruvbox.nvim';
    'olimorris/onedarkpro.nvim';
    'jdsimcoe/abstract.vim';
    'tlhr/anderson.vim';
    'ayu-theme/ayu-vim';
    'romainl/Apprentice';
    'ajmwagar/vim-deus';
    'wadackel/vim-dogrun';
    'romainl/flattened';
    'rakr/vim-one';
    'sonph/onehalf';
    'sts10/vim-pink-moon';
    'junegunn/seoul256.vim';
    'AlessandroYorba/Sierra';
    'rakr/vim-two-firewatch';
    'sainnhe/everforest';
    'cpea2506/one_monokai.nvim';

    -- Tree Sitter
    {
        'nvim-treesitter/nvim-treesitter',
        build= ':TSUpdate'
    },
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/playground',

    -- Tree
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        -- tag = 'nightly', -- optional, updated every week. (see issue #1193)
    },
    -- Refactor
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
        },
    },

    -- buffer line
    {
        'akinsho/bufferline.nvim',
        dependencies = 'kyazdani42/nvim-web-devicons',
    },

    -- lsp config
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer',
        'onsails/lspkind-nvim'
    },
    -- linters and formatters
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- outline
    'simrat39/symbols-outline.nvim',

    -- cmp, config from: https://gist.github.com/mengwangk/e5b64dbbeadc81b0129f274908a7b692
    'L3MON4D3/LuaSnip',
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-emoji',
            'saadparwaiz1/cmp_luasnip',
            'f3fora/cmp-spell',
        }
    },
    'roobert/tailwindcss-colorizer-cmp.nvim',
    {
        'NvChad/nvim-colorizer.lua',
        config = function() require('colorizer').setup{} end
    },

    -- indent line
    'lukas-reineke/indent-blankline.nvim',

    -- motion
    'ggandor/lightspeed.nvim',

    -- surround
    'kylechui/nvim-surround',

    -- telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        }
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable 'make' == 1 },
    'nvim-telescope/telescope-ui-select.nvim',

    -- git
    'lewis6991/gitsigns.nvim',

    -- editing
    'junegunn/vim-easy-align',
    'rmagatti/alternate-toggler',

    -- status line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
    },

    -- comment
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        -- Uncomment next line if you want to follow only stable versions
    },
    'numToStr/Comment.nvim',

    -- go
    {
        'fatih/vim-go',
    },
});
