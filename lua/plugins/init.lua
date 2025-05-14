return {
    { "LazyVim/LazyVim", --[[ import = "lazyvim.plugins" ]] },
    {
        "folke/snacks.nvim",
        enabled = not IS_USING_VSCODE,
        priority = 1000,
        event = "BufReadPre", -- 讓keys啟動的話，indent會失效
        opts = {
            bigfile      = { enabled = true },
            indent       = { enabled = true },
            image        = { enabled = true },
            input        = { enabled = true },
            picker       = { enabled = true },
            notifier     = { enabled = true },
            statuscolumn = { enabled = true },
        },
        keys = {
            { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
            { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
            { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<leader>nh", function() Snacks.picker.notifications() end, desc = "Notification History" },
            { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
            -- find
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
            { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
            { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
            { "<leader>fs", function() Snacks.picker.grep() end, desc = "Find String" },
            -- git
            { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
            { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
            { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
            { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
            { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
            { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
            { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
            -- Grep
            { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
            { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
            { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
            { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
            -- search
            { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
            { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
            { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
            { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
            { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
            { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
            { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
            { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
            { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
            { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
            { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
            { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
            { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
            { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
        },
    },
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
            require('leap').set_default_mappings();
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
        enabled = not IS_USING_VSCODE,
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
            local Terminal  = require('toggleterm.terminal').Terminal;
            local lazygit = Terminal:new {
                cmd = "lazygit",
                hidden = true,
                direction = "float",
                float_opts = {
                    border = "single",
                },
            };

            function _Lazygit_toggle()
                lazygit:toggle()
                vim.keymap.set("t", "<esc>", "<esc>", { buffer = lazygit.bufnr, nowait = true });
            end
        end,
        enabled = not IS_USING_VSCODE,
        cmd = "ToggleTerm",
        keys = {
            { "<C-t>", "<cmd>exe v:count1 . 'ToggleTerm'<cr>", mode = {"n", "t"}, desc = "Toggle Terminal" },
            { "<leader>lg", "<cmd>lua _Lazygit_toggle()<CR>", desc = "Lazygit" },
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
