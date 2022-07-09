-- https://github.com/hrsh7th/nvim-cmp
require 'cmp'.setup {
    snippet = {
        expand = function(args)
            -- vim.fn["UltiSnips#Anon"](args.body);
            require("luasnip").lsp_expand(args.body)
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer', keyword_length = 5 },
        { name = 'path' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
    },
    mapping = require 'keymap.cmp',
    formatting = {
        format = require "lspkind".cmp_format {
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]",
                luasnip = "[snip]",
                gh_issues = "[issues]",
                tn = "[TabNine]",
            },
        },
    },
};
