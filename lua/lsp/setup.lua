require("nvim-lsp-installer").setup {
    ensure_installed = {"sumneko_lua"},
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    },
};

-- TODO: 拆分lua設定的程式碼到另外一個檔案
require "lspconfig"["sumneko_lua"].setup {
    settings = {
        Lua = {
            runtime = {version = "LuaJIT"},
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

