return {
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true,
        opt = {
            snippet_engine = "luasnip",
        },
        keys = {
            { '<leader>nf', '<cmd>Neogen func<cr>',  desc = "Annotate Function", noremap = true, silent = true },
            { '<leader>nc', '<cmd>Neogen class<cr>', desc = "Annotate Class",    noremap = true, silent = true },
            { '<leader>nt', '<cmd>Neogen type<cr>',  desc = "Annotate Type",     noremap = true, silent = true },
            { '<leader>na', '<cmd>Neogen file<cr>',  desc = "Annotate File",     noremap = true, silent = true },
        },
    },
    {
        'numToStr/Comment.nvim',
        keys = {
            -- https://github.com/numToStr/Comment.nvim/blob/master/plugin/Comment.lua
            { '<leader>;', '<Plug>(comment_toggle_linewise_current)',  desc = "Comment Line"},
            { '<leader>;', '<Plug>(comment_toggle_linewise_visual)gv', desc = "Comment Lines", mode = 'v'},
        },
    },
};
