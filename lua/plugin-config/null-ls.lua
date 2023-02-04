local null_ls = require("null-ls");

-- How to config: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
-- Config list: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
null_ls.setup {
    sources = {
        -- code actions
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.refactoring,
        -- diagnostics
        null_ls.builtins.diagnostics.eslint_d,
        -- foramt
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.eslint_d,
    },
};
