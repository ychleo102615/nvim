return {
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
};
