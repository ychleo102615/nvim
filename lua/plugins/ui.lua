-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua
return {
    -- dashboard
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        -- config = function() require'alpha'.setup(require'alpha.themes.dashboard'.config) end,
        opts = function()
            local dashboard = require("alpha.themes.dashboard")
            local logo = [[
            ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
            ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
            ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
            ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
            ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
            ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
            ]]

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
        opts = {
            options = {
                mode = "tabs",
                numbers = "oridinal",
                offsets = {{
                    filetype   = "NvimTree",
                    text       = "File Explorer",
                    highlight  = "Directory",
                    text_align = "left"
                }},
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(_, _, diag)
                    local icons = require("lazyvim.config").icons.diagnostics
                    local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                    .. (diag.warning and icons.Warn .. diag.warning or "")
                    return vim.trim(ret)
                end,
            }
        },
        cond = not IS_USING_VSCODE,
    },
    -- status line 底部狀態條
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                -- theme = 'gruvbox-material',
                -- theme = 'seoul256',
                -- theme = 'everforest',
                -- theme = 'gruvbox',
                theme = "auto",
            },
            sections = {
                lualine_y = {
                    { "progress", separator = "", padding = { left = 1, right = 0 } },
                    { "location", padding = { left = 0, right = 1 } },
                },
                lualine_z = {
                    function()
                        return " " .. os.date("%R")
                    end,
                },
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
            },
        },
    },

    -- noicer ui
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify"
        },
        event = "VeryLazy",
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"]                = true,
                },
            },
            presets = {
                -- bottom_search         = true,
                command_palette       = true,
                long_message_to_split = true,
            },
        },
        -- stylua: ignore
        keys = {
            { "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end,                 desc = "Redirect Cmdline",     mode = "c" },
            { "<leader>snl", function() require("noice").cmd("last") end,                                   desc = "Noice Last Message" },
            { "<leader>snh", function() require("noice").cmd("history") end,                                desc = "Noice History" },
            { "<leader>sna", function() require("noice").cmd("all") end,                                    desc = "Noice All" },
            { "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  desc = "Scroll forward",       silent = true, expr = true, mode = {"i", "n", "s"} },
            { "<c-b>",       function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, desc = "Scroll backward",      silent = true, expr = true, mode = {"i", "n", "s"}},
        },
    },
};
