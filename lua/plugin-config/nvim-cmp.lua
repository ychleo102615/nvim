-- https://github.com/hrsh7th/nvim-cmp
require 'cmp'.setup {
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body);
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    },
    mapping = require 'keymap.cmp',
};
