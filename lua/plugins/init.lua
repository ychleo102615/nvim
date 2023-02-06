return {
    { "folke/which-key.nvim", config = true },
    -- { "folke/neoconf.nvim", cmd = "Neoconf" },
    -- "folke/neodev.nvim",

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
        dependencies = 'nvim-tree/nvim-web-devicons',
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
        config = function() require('colorizer').setup {} end
    },

    -- indent line
    'lukas-reineke/indent-blankline.nvim',

    -- motion
    'ggandor/leap.nvim',
    -- 'ggandor/lightspeed.nvim',

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
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    -- go
    {
        'fatih/vim-go',
    },
};
