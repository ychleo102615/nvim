if IS_USING_VSCODE then
    print("[NVIM] Skip lsp")
    return {};
end
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/init.lua

local NVIM_ENV = "/.config/nvim";

return {
    {
        "mason-org/mason.nvim",
        cmd    = "Mason",
        keys   = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        config = true,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        event = "BufReadPre",
        dependencies = {
            { "neovim/nvim-lspconfig" },
        },
        opts = {
            --[[
            Server List and theris githubs
            https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
            :help lspconfig-all or https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
            ]]
            ensure_installed = {
                "lua_ls",
                "gopls",
                "clangd",
                "tailwindcss",
                "pyright",
                "vtsls",  -- 使用 vtsls 而不是 ts_ls，因為 Vue 需要它
                "vue_ls",
            },
            -- 排除需要自定義配置的 servers
            automatic_enable = {
                exclude = { 'vtsls', 'vue_ls' },
            },
        },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)

            -- vtsls: 配置 Vue TypeScript 支持
            vim.lsp.config('vtsls', {
                settings = {
                    vtsls = {
                        tsserver = {
                            globalPlugins = {
                                {
                                    name = '@vue/typescript-plugin',
                                    location = vim.fn.stdpath('data') .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
                                    languages = { 'vue' },
                                },
                            },
                        },
                    },
                },
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            })
            vim.lsp.enable('vtsls')

            -- vue_ls: 啟用 Vue Language Server
            vim.lsp.enable('vue_ls')
        end,
    },
    -- linters and formatters
    {
        -- https://github.com/maan2003/lsp_lines.nvim
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
        "hasansujon786/nvim-navbuddy",
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
        dependencies = {
            "Bilal2453/luvit-meta",
        },
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                "lazy.nvim",
                "snacks.nvim",
                -- Only load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
                -- Only load the lazyvim library when the `LazyVim` global is found
                { path = "LazyVim", words = { "LazyVim" } },
            },
        },
        enabled = function()
            return vim.fn.getcwd():match(NVIM_ENV);
        end,

    },
};
