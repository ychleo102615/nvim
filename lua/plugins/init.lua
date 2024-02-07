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
            { "<leader>so", "<cmd>SymbolsOutline<cr>", desc = "[S]how Symbols [O]utline" },
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
        'ggandor/leap-spooky.nvim',
        opts = {
            affixes = {
                remote = {
                    -- r is conflicting with return object
                    window = 'g',
                    cross_window = 'G',
                },
            },
        },
    },
    {
        'smoka7/hop.nvim',
        version = "*",
        config = true,
        keys = {
            { "gh", "<cmd>HopWord<cr>",  mode = "", desc = "Hop Word"  },
            { "gH", "<cmd>HopChar1<cr>", mode = "", desc = "Hop Char1" },
        },
    },
    {
        "chrisgrieser/nvim-spider",
        event = "BufReadPre",
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
                direction = "horizontal",
                size = function (term)
                    if term.direction == "horizontal" then
                        return vim.o.lines * 0.3;
                    elseif term.direction == "vertical" then
                        return vim.o.columns * 0.35;
                    end
                end
            };
        end,
        enabled = not IS_USING_VSCODE,
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
        "sindrets/diffview.nvim",
        opts = {
            file_history_panel = {
                win_config = {
                    position = "top",
                    height = 20,
                },
            },
        },
        event = "BufReadPre",
        keys = {
            { "<leader>gdo", "<cmd>DiffviewOpen<cr>",        mode = {"n"}, desc = "Git Diffview Open" },
            { "<leader>gdc", "<cmd>DiffviewClose<cr>",       mode = {"n"}, desc = "Git Diffview Close" },
            { "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", mode = {"n"}, desc = "Git Diffview File History" },
        },
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            keymaps = {
                -- <C-v> 要用來編輯
                ["<C-s>"] = "actions.select_vsplit",
                ["<C-h>"] = false,
                ["<C-l>"] = false,
                ["<C-x>"] = "actions.select_split",
                ["<esc>"] = "actions.close",
                ["<C-g>"] = "actions.refresh",
            },
        },
        keys = {
            { "<leader>oi", "<cmd>tabnew<cr><cmd>Oil<cr>", mode = {"n"}, desc = "Open Oil" }
        },
    },
};
