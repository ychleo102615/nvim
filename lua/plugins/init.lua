return {
    { "LazyVim/LazyVim", --[[ import = "lazyvim.plugins" ]] },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = true
    },

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
