return {
    { "LazyVim/LazyVim", --[[ import = "lazyvim.plugins" ]] },
    -- { "LazyVim/LazyVim", --[[ import = "lazyvim.plugins.ui" ]] },
    { "folke/which-key.nvim", config = true },
    -- { "folke/neoconf.nvim", cmd = "Neoconf" },

    -- Refactor
    {
       "ThePrimeagen/refactoring.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
        },
    },

    -- outline
    {
        'simrat39/symbols-outline.nvim',
        opts = {
            autofold_depth = 0,
        },
        cond = not IS_USING_VSCODE,
    },

    -- indent line
    'lukas-reineke/indent-blankline.nvim',
    -- active indent guide and indent text objects
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = "BufReadPre",
        opts = {
            symbol = "│",
            options = { try_as_border = true },
        },
        config = function(_, opts)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
            require("mini.indentscope").setup(opts)
        end,
    },

    -- motion
    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').add_default_mappings();
        end
    },

    -- surround
    'kylechui/nvim-surround',

    -- telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        }
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = vim.fn.executable 'make' == 1
    },
    'nvim-telescope/telescope-ui-select.nvim',

    -- editing
    'junegunn/vim-easy-align',
    'rmagatti/alternate-toggler',

    -- go
    {
        'fatih/vim-go',
        config = function()
            vim.g.go_fmt_autosave = false;
        end,
    },
};
