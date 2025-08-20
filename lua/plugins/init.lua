return {
    { "LazyVim/LazyVim", --[[ import = "lazyvim.plugins" ]] },
    {
        "folke/snacks.nvim",
        enabled = not IS_USING_VSCODE,
        priority = 1000,
        event = "BufReadPre", -- 讓keys啟動的話，indent會失效
        opts = {
            bigfile      = {},
            indent       = {},
            image        = {},
            picker       = {
                actions = {
                    drop_open = function(picker, item)
                        picker:close()
                        item = item or (picker:selected { fallback = true } or {})[1]
                        if not item then return end
                        local file = item.file or item.path or item.text
                        local pos = item.pos
                        local win = vim.api.nvim_get_current_win()
                        if not file then
                            return;
                        end
                        vim.schedule(function()
                            vim.cmd("drop " .. vim.fn.fnameescape(file))
                            if picker.opts.jump.match then
                                pos = picker.matcher:bufpos(vim.api.nvim_get_current_buf(), item) or pos
                            end
                            if not pos or not win then
                                return;
                            end
                            if pos and pos[1] > 0 then
                                vim.api.nvim_win_set_cursor(win, { pos[1], pos[2] })
                                vim.cmd("norm! zzzv")
                            elseif item.search then
                                vim.cmd(item.search)
                                vim.cmd("noh")
                            end

                        end)
                    end,
                },
                win = {
                    input = {
                        keys = {
                            ["<c-o>"] = { "drop_open", mode = { "n", "i" } },
                            -- ["<c-f>"] = { "drop", mode = { "n", "i" } },  -- 原生功能，但是跳轉完會返回原本視窗
                        },
                    },
                },
            },
            notifier     = {},
            statuscolumn = {},
            words        = {},
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
            -- Other
            { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
            { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
            { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
            { "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit" },
            { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
            { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
            { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
            { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
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
        'smoka7/hop.nvim',
        version = "*",
        config = true,
        keys = {
            { "gh", "<cmd>HopWord<cr>",  mode = "", desc = "Hop Word"  },
            { "gH", "<cmd>HopChar1<cr>", mode = "", desc = "Hop Char1" },
        },
    },
    {
        'aaronik/treewalker.nvim',
        opts = {
            highlight = true,
            highlight_duration = 250,
            highlight_group = 'CursorLine',
        },
        keys = {
            { '<A-C-k>', '<cmd>Treewalker Up<cr>',    mode = { 'n', 'v' }, desc = "Treewalker Up"    },
            { '<A-C-j>', '<cmd>Treewalker Down<cr>',  mode = { 'n', 'v' }, desc = "Treewalker Down"  },
            { '<A-C-h>', '<cmd>Treewalker Left<cr>',  mode = { 'n', 'v' }, desc = "Treewalker Left"  },
            { '<A-C-l>', '<cmd>Treewalker Right<cr>', mode = { 'n', 'v' }, desc = "Treewalker Right" },
            { '<A-C-S-K>', '<cmd>Treewalker SwapUp<cr>',    desc = "Treewalker Swap Up"   },
            { '<A-C-S-J>', '<cmd>Treewalker SwapDown<cr>',  desc = "Treewalker Swap Down" },
            { '<A-C-S-H>', '<cmd>Treewalker SwapLeft<cr>',  desc = "Treewalker Swap Left" },
            { '<A-C-S-L>', '<cmd>Treewalker SwapRight<cr>', desc = "Treewalker Swap Right" },
        },
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
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
        "chrisgrieser/nvim-early-retirement",
        config = true,
        event = "VeryLazy",
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
