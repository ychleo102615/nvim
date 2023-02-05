-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/init.lua
local testEvent = "BufReadPre";
-- local testEvent = nil;

-- How to config: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
-- Config list: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local function getNullLsOpts()
    local null_ls = require("null-ls");
    return {
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
end

local on_attach = require("keymap.lsp").on_attach;
--[[
sumneko server config: https://github.com/sumneko/lua-language-server/wiki/Configuration-File
]]
local NVIM_ENV = "/.config/nvim";
local function getNvimSetting()
    if not vim.fn.getcwd():match(NVIM_ENV) then
        return;
    end
    return {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    };
end

return {
    -- cmdline tools and lsp servers
    {
        "williamboman/mason.nvim",
        -- cmd    = "Mason",
        keys   = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        config = true,
    },
    {
        "williamboman/mason-lspconfig",
        opts = {
            --[[
            Server List and theris githubs
            https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
            :help lspconfig-all or https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            ]]
            ensure_installed = {
                "sumneko_lua",
                "gopls",
                "clangd",
                "tsserver",
                "volar",
                "tailwindcss",
            }
        },
        config = function()
            -- :h mason-lspconfig-automatic-server-setup
            local lspconfig = require("lspconfig");
            require("mason-lspconfig").setup_handlers {
                function(serverName)
                    lspconfig[serverName].setup { on_attach = on_attach }
                end,
                ["sumneko_lua"] = function()
                    lspconfig.sumneko_lua.setup {
                        on_attach = on_attach,
                        settings  = getNvimSetting(),
                    };
                end,
            };

        end,
    },
    { 'neovim/nvim-lspconfig' },
    { 'onsails/lspkind-nvim' },
    -- linters and formatters
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event        = testEvent,
        opts         = getNullLsOpts,
    },
};
