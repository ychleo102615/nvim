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
            vim.api.nvim_create_autocmd('ColorScheme', {
                callback = function()
                    vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = 'grey' })
                end,
            });
        end
    },
    {
        "chrisgrieser/nvim-spider",
        config = function()
            local motion = require("spider").motion;
            vim.keymap.set({"n", "x"}, "w",  function() return motion("w")  end, { desc = "Spider-w"  })
            vim.keymap.set({"n", "x"}, "e",  function() return motion("e")  end, { desc = "Spider-e"  })
            vim.keymap.set({"n", "x"}, "b",  function() return motion("b")  end, { desc = "Spider-b"  })
            vim.keymap.set({"n", "x"}, "ge", function() return motion("ge") end, { desc = "Spider-ge" })
        end,
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
    {
        'echasnovski/mini.splitjoin',
        config = function ()
            require('mini.splitjoin').setup();
        end,
        version = false
    },
    -- go
    {
        'fatih/vim-go',
        ft = "go",
        config = function()
            vim.g.go_fmt_autosave = false;
        end,
    },
    -- java
    {
        'mfussenegger/nvim-jdtls',
        -- ft = "java",
    },
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup {
                size = 80,
                direction = "vertical",
            };
        end,
        cmd = "ToggleTerm",
        keys = {
            { "<C-t>", "<cmd>exe v:count1 . 'ToggleTerm'<cr>", mode = {"n", "t"}, desc = "Toggle Terminal" },
        },
    },
    {
        "chrisgrieser/nvim-early-retirement",
        config = true,
        event = "VeryLazy",
    },
    {
        "rbong/vim-flog",
        dependencies = {
            "tpope/vim-fugitive"
        },
        keys = {
            { "<leader>gg", "<cmd>Flog<cr>", mode = {"n"}, desc = "Git Flog" },
        },
    },
    {
        "sindrets/diffview.nvim",
        event = "BufReadPre",
        keys = {
            { "<leader>gdo", "<cmd>DiffviewOpen<cr>",  mode = {"n"}, desc = "Git Diffview Open" },
            { "<leader>gdc", "<cmd>DiffviewClose<cr>", mode = {"n"}, desc = "Git Diffview Close" },
        },
    },
};
