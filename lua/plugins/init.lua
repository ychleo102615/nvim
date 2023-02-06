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

    -- indent line
    'lukas-reineke/indent-blankline.nvim',

    -- motion
    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').add_default_mappings();
        end
    },
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
