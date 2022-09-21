-- require('nvim-lsp-installer').setup {
--     ensure_installed = {
--         "sumneko_lua",
--         "clangd",
--         "tsserver",
--     },
--     ui = {
--         icons = {
--             server_installed   = "✓",
--             server_pending     = "➜",
--             server_uninstalled = "✗"
--         }
--     },
-- };

require("mason").setup();
require("mason-lspconfig").setup{
    -- The following is server name
    ensure_installed = {
        "sumneko_lua",
        "gopls",
        "clangd",
        "tsserver",
    }
};

-- TODO: 拆分lua設定的程式碼到另外一個檔案
local lspconfig = require('lspconfig');
lspconfig.sumneko_lua.setup {
    on_attach = function(_client, bufnr)
        return require('keymap.lsp').on_attach(bufnr);
    end,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = {
                globals = {"vim"},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
};

lspconfig.clangd.setup {};
lspconfig.tsserver.setup {};
-- lspconfig.golangci_lint_ls.setup {};
lspconfig.gopls.setup {
    on_attach = function(_client, bufnr)
        return require('keymap.lsp').on_attach(bufnr);
    end,
};
