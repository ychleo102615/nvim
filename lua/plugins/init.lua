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
    {
        'junegunn/vim-easy-align',
        cmd = "EasyAlign",
        keys = {
            { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "Easy Align" },
        },
    },
    {
        'rmagatti/alternate-toggler',
        cmd = "ToggleAlternate",
        keys = {
            { "<leader>i", "<cmd>ToggleAlternate<cr>", desc = "Toggle Boolean" },
        },
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    -- go
    {
        'fatih/vim-go',
        ft = "go",
        config = function()
            vim.g.go_fmt_autosave = false;
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        config = true,
        cmd = "ToggleTerm",
        keys = {
            { "<leader>ti", "<cmd>exe v:count1 . 'ToggleTerm'<cr>", mode = {"n", "t"}, desc = "Toggle Terminal" },
            { "<C-t>",      "<cmd>exe v:count1 . 'ToggleTerm'<cr>", mode = {"n", "t"}, desc = "Toggle Terminal" },
            { "<leader>ta", "<cmd>ToggleTermToggleAll<cr>",         mode = {"n", "t"}, desc = "Toggle All Terminal" },
        },
    }
};
