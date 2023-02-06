return {
    -- buffer line
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
};
