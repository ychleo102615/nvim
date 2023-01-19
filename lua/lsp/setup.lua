require("mason").setup();
require("mason-lspconfig").setup{
    -- The following is server name
    -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
    ensure_installed = {
        "sumneko_lua",
        "gopls",
        "clangd",
        "tsserver",
        "volar",
        "tailwindcss",
    }
};

local on_attach = require("keymap.lsp").on_attach;
local lspconfig = require("lspconfig");
-- :h mason-lspconfig-automatic-server-setup
require("mason-lspconfig").setup_handlers {
    function (serverName)
        lspconfig[serverName].setup { on_attach = on_attach }
    end,
    ["sumneko_lua"] = function()
        lspconfig.sumneko_lua.setup {
            on_attach = on_attach,
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
    end,
};
