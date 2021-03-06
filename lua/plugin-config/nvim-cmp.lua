-- https://github.com/hrsh7th/nvim-cmp
require('cmp').setup {
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
        { name = 'luasnip' },
        { name = 'spell' },
        { name = 'calc' },
        { name = 'emoji' },
        { name = 'nvim_lua' },
    },
    mapping = require 'keymap.cmp',
    formatting = {
        format = require "lspkind".cmp_format {
            with_text = true,
            menu = {
                nvim_lsp = "[LSP]",
                buffer = "[buf]",
                path = "[path]",
                luasnip = "[snip]",
                spell = "[spell]",
                calc = "[calc]",
                emoji = "[emoji]",
                nvim_lua = "[api]",
            },
        },
    },
};
