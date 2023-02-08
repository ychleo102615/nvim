return {
    { "LazyVim/LazyVim", --[[ import = "lazyvim.plugins" ]] },
    -- { "LazyVim/LazyVim", --[[ import = "lazyvim.plugins.ui" ]] },
    { "folke/which-key.nvim", config = true },
    -- { "folke/neoconf.nvim", cmd = "Neoconf" },

    -- outline
    {
        'simrat39/symbols-outline.nvim',
        opts = {
            autofold_depth = 0,
        },
        keys = {
            { "<leader>o", "<cmd>SymbolsOutline<cr>", desc = "Show Symbols [O]utline" },
        },
        cond = not IS_USING_VSCODE,
    },

    -- motion
    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').add_default_mappings();
        end
    },

    -- surround
    {
        'kylechui/nvim-surround',
        event = "BufReadPre",
        config = true,
    },

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
    {
        'rmagatti/alternate-toggler',
        cmd = "ToggleAlternate",
        keys = {
            { "<leader>i", "<cmd>ToggleAlternate<cr>", desc = "Toggle Boolean" },
        },
    },

    -- go
    {
        'fatih/vim-go',
        ft = "go",
        config = function()
            vim.g.go_fmt_autosave = false;
        end,
    },
};
