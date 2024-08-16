if IS_USING_VSCODE then
    print("[NVIM] Skip lsp")
    return {};
end
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/init.lua

-- How to config: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
-- Config list: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local function getNullLsOpts()
    local null_ls = require("null-ls");
    return {
        --[[
        -- eslint_d 似乎不會看專案內的prettier config
        -- https://www.reddit.com/r/neovim/comments/uhgwyh/nullls_eslint_formatter_doesnt_pick_up_project/
        --]]
        sources = {
            -- code actions
            null_ls.builtins.code_actions.eslint,
            null_ls.builtins.code_actions.gitsigns,
            null_ls.builtins.code_actions.refactoring,
            -- diagnostics
            null_ls.builtins.diagnostics.eslint,
            -- foramt
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.eslint,
        },
    };
end

local on_attach = function(client, bufnr)
    require("keymap.lsp").on_attach(client, bufnr);
    if client.name ~= "tailwindcss" then
        require("nvim-navbuddy").attach(client, bufnr);
    end
    -- print(vim.inspect(client));
    -- print(client.name .. " attached");
end
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
        cmd    = "Mason",
        keys   = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        config = true,
    },
    {
        "williamboman/mason-lspconfig",
        event = "BufReadPre",
        dependencies = {
            { 'neovim/nvim-lspconfig' },
        },
        opts = {
            --[[
            Server List and theris githubs
            https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
            :help lspconfig-all or https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            ]]
            ensure_installed = {
                "lua_ls",
                "gopls",
                "clangd",
                "tsserver",
                "volar",
                "tailwindcss",
                "pyright"
            }
        },
        config = function(_, opts)
            -- :h mason-lspconfig-automatic-server-setup
            local lspconfig = require("lspconfig");
            require("mason-lspconfig").setup(opts);
            require("mason-lspconfig").setup_handlers {
                function(serverName)
                    lspconfig[serverName].setup {
                        on_attach = on_attach
                    }
                end,
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup {
                        on_attach = on_attach,
                        settings  = getNvimSetting(),
                    };
                end,
                ["clangd"] = function()
                    -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428#issuecomment-997226723
                    local capabilities = vim.lsp.protocol.make_client_capabilities();
                    capabilities.offsetEncoding = { "utf-16" };
                    lspconfig.clangd.setup {
                        on_attach = on_attach,
                        capabilities = capabilities
                    };
                end,
            };
        end,
    },
    -- linters and formatters
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event        = "BufReadPre",
        opts         = getNullLsOpts,
    },
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        event = "BufReadPre",
        config = function()
            vim.diagnostic.config({
                virtual_text = false,
                virtual_lines = false,
            });
            require("lsp_lines").setup();
        end,
        keys = {
            { '<leader>tl', function() require("lsp_lines").toggle() end, desc = "Toggle Lsp_lines" },
        },
    },
    {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
            "neovim/nvim-lspconfig",
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim"
        },
        config = true,
        keys = {
            { '<leader>nb', '<cmd>Navbuddy<cr>', desc = "Nav Buddy" },
        },
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
        enabled = function()
            return vim.fn.getcwd():match(NVIM_ENV);
        end,

    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
};
