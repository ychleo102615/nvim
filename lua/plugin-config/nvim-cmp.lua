-- https://github.com/hrsh7th/nvim-cmp
require("tailwindcss-colorizer-cmp").setup({
    color_square_width = 2,
});
local cmp = require('cmp');
cmp.setup {
    snippet = {
        expand = function(args)
            -- vim.fn["UltiSnips#Anon"](args.body);
            require("luasnip").lsp_expand(args.body)
        end,
    },
    sources = {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'buffer', keyword_length = 5 },
        { name = 'path' },
        { name = 'spell' },
        { name = 'calc' },
        { name = 'emoji' },
        { name = 'nvim_lua' },
    },
    mapping = require 'keymap.cmp',
    formatting = {
        fields = {
            cmp.ItemField.Menu,
            cmp.ItemField.Abbr,
            cmp.ItemField.Kind,
        },
        format = require "lspkind".cmp_format {
            mode = "symbol_text",
            with_text = true,
            menu = {
                luasnip  = "[SNIP]",
                nvim_lsp = "[LSP]",
                buffer   = "[BUF]",
                path     = "[PATH]",
                spell    = "[SPELL]",
                calc     = "[CALC]",
                emoji    = "[EMOJI]",
                nvim_lua = "[API]",
            },
            before = require("tailwindcss-colorizer-cmp").formatter,
        },
    },
};

