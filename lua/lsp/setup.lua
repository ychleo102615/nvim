require("mason").setup();
require("mason-lspconfig").setup{
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
};

local on_attach = require("keymap.lsp").on_attach;
local lspconfig = require("lspconfig");
-- require("tools.tool").echo(vim.api.nvim_get_runtime_file("", true));
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
                globals = {"vim"},
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
-- :h mason-lspconfig-automatic-server-setup
require("mason-lspconfig").setup_handlers {
    function (serverName)
        lspconfig[serverName].setup { on_attach = on_attach }
    end,
    ["sumneko_lua"] = function()
        lspconfig.sumneko_lua.setup {
            on_attach = on_attach,
            settings  = getNvimSetting(),
        };
    end,
};
