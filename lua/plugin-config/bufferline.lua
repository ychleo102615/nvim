require('bufferline').setup {
    options = {
        mode = "tabs",
        numbers = "oridinal",
        offsets = {{
            filetype   = "NvimTree",
            text       = "File Explorer",
            highlight  = "Directory",
            text_align = "left"
        }},
        -- diagnostics = "nvim_lsp",
        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
        --     return "("..count..")"
        -- end,
    }
};
