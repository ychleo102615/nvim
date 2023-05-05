if IS_USING_VSCODE then
    print("[NVIM] Skip ui");
    return {};
end
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua

local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]];
local function clock()
    return " " .. os.date("%R")
end
local window = function()
    return "win: " .. vim.api.nvim_win_get_number(0);
end
local bufferId = function()
    return "buf: " .. vim.api.nvim_get_current_buf();
end

return {
    -- dashboard
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        -- config = function() require'alpha'.setup(require'alpha.themes.dashboard'.config) end,
        opts = function()
            local dashboard = require("alpha.themes.dashboard")
            ---@diagnostic disable-next-line: missing-parameter
            dashboard.section.header.val = vim.split(logo, "\n")
            dashboard.section.buttons.val = {
                dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
                dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
                dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
                dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
                dashboard.button("s", "勒" .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
                dashboard.button("l", "鈴" .. " Lazy", ":Lazy<CR>"),
                dashboard.button("q", " " .. " Quit", ":qa<CR>"),
            }
            for _, button in ipairs(dashboard.section.buttons.val) do
                button.opts.hl = "AlphaButtons"
                button.opts.hl_shortcut = "AlphaShortcut"
            end
            dashboard.section.footer.opts.hl = "Type"
            dashboard.section.header.opts.hl = "AlphaHeader"
            dashboard.section.buttons.opts.hl = "AlphaButtons"
            dashboard.opts.layout[1].val = 8
            return dashboard
        end,
        config = function(_, dashboard)
            vim.b.miniindentscope_disable = true

            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "AlphaReady",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            require("alpha").setup(dashboard.opts)

            vim.api.nvim_create_autocmd("User", {
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
    },
    -- buffer line 上方頁籤
    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = "BufReadPre",
        opts = {
            options = {
                mode = "tabs",
                numbers = "buffer_id",
                indicator = {
                    style = 'underline',
                },
                offsets = {{
                    filetype   = "NvimTree",
                    text       = "File Explorer",
                    highlight  = "Directory",
                    text_align = "left"
                }},
                always_show_bufferline = false,
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(_, _, diag)
                    local icons = require("lazyvim.config").icons.diagnostics
                    local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                    .. (diag.warning and icons.Warn .. diag.warning or "")
                    return vim.trim(ret)
                end,
                separator_style = "padded_slant"
            }
        },
        keys = {
            { "]r", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
            { "[r", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
        },
    },
    -- status line 底部狀態條
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = "VeryLazy",
        opts = function() return {
            options = {
                disabled_filetypes = {
                    statusline = { "dashboard", "lazy", "alpha" },
                    winbar     = { "dashboard", "lazy", "alpha" },
                },
            },
            sections = {
                lualine_y = {
                    { "progress", separator = "", padding = { left = 1, right = 0 } },
                    { "location", padding = { left = 1, right = 1 } },
                },
                lualine_z = { clock },
            },
            winbar = {
                lualine_a = {
                    {
                        'filename',
                        file_status    = true,  -- Displays file status (readonly status, modified status)
                        newfile_status = false, -- Display new file status (new file means no write after created)
                        path = 1,  -- 0: Just the filename
                        -- 1: Relative path
                        -- 2: Absolute path
                        -- 3: Absolute path, with tilde as the home directory
                        symbols = {
                            modified = '[+]',   -- Text to show when the file is modified.
                            readonly = '[-]',   -- Text to show when the file is non-modifiable or readonly.
                            unnamed  = '',      -- Text to show for unnamed buffers.
                            newfile  = '[New]', -- Text to show for new created file before first writting
                        },
                    },
                },
                lualine_y = { window },
                lualine_z = { bufferId },
            },
            inactive_winbar = {
                lualine_b = {
                    {
                        'filename',
                        file_status    = true,
                        newfile_status = false,
                        path = 1,
                        symbols = {
                            modified = '[+]',
                            readonly = '[-]',
                            unnamed  = '[No Name]',
                            newfile  = '[New]',
                        },
                    },
                },
                lualine_y = { window },
                lualine_z = { bufferId },
            },
        } end,
    },
    -- 通知彈窗
    {
        "rcarriga/nvim-notify",
        keys = {
            {
                "<leader>un",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Delete all Notifications",
            },
        },
        opts = {
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
        config = function ()
            vim.notify = require("notify");
        end,
    },
    -- 改名彈窗
    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },
    -- Lsp 右下角狀態顯示
    {
        'j-hui/fidget.nvim',
        -- event = "VeryLazy",
        event = "BufReadPost",
        opts = {
            text = {
                spinner = "dots",
            },
        },
    },
    -- 縮排線 indent line
    {
        'lukas-reineke/indent-blankline.nvim',
        event = "BufReadPost",
    },
    -- 動態縮排效果線 active indent guide and indent text objects
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
                pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "term" },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
            require("mini.indentscope").setup(opts)
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            filetypes = {
                'css',
                'javascript',
                html = { mode = 'foreground'; }
            },
            user_default_options = {
                tailwind = true,
                -- mode = 'virtualtext',
                -- virtualtext = "▇",
            },
        },
    },
    -- noice ui 合併了notify, nui等美化工具 (元件不穩定)
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify"
        },
        event = "VeryLazy",
        cond = false,
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"]                = true,
                },
            },
            presets = {
                bottom_search         = true,
                command_palette       = true,
                long_message_to_split = true,
            },
        },
        -- stylua: ignore
        keys = {
            { "<leader>un",  function() require("notify").dismiss { } end, desc = "Close Notifications" },
            { "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end,                 desc = "Redirect Cmdline",     mode = "c" },
            { "<leader>snl", function() require("noice").cmd("last") end,                                   desc = "Noice Last Message" },
            { "<leader>snh", function() require("noice").cmd("history") end,                                desc = "Noice History" },
            { "<leader>sna", function() require("noice").cmd("all") end,                                    desc = "Noice All" },
            { "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  desc = "Scroll forward",       silent = true, expr = true, mode = {"i", "n", "s"} },
            { "<c-b>",       function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, desc = "Scroll backward",      silent = true, expr = true, mode = {"i", "n", "s"}},
        },
    },
};
