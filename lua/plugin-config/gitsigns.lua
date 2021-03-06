require('gitsigns').setup {
    signs = {
        add          = { hl = "GitSignsAdd",    text = "▎",  numhl = "GitSignsAddNr",    linehl = "GitSignsAddLn"    },
        change       = { hl = "GitSignsChange", text = "▎",  numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        delete       = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        topdelete    = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        changedelete = { hl = "GitSignsChange", text = "▎",  numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    },
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 100,
    },
    current_line_blame_formatter = '      <author>, <author_time:%Y-%m-%d %H:%M:%S, %R> - <summary>',
    on_attach = function(bufnr)
        require('keymap.gitsigns')(bufnr);
    end,
};
