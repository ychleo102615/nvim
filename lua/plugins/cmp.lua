return {
    -- cmp, config from: https://gist.github.com/mengwangk/e5b64dbbeadc81b0129f274908a7b692
    "L3MON4D3/LuaSnip",
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-emoji",
            "saadparwaiz1/cmp_luasnip",
            "f3fora/cmp-spell",
            "onsails/lspkind-nvim",
            "roobert/tailwindcss-colorizer-cmp.nvim",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        -- vim.fn["UltiSnips#Anon"](args.body);
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer", keyword_length = 5 },
                    { name = "path" },
                    { name = "spell" },
                    { name = "calc" },
                    { name = "emoji" },
                    { name = "nvim_lua" },
                },
                --mapping = require("keymap.cmp"),
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"]     = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"]     = cmp.mapping.abort(),
                    ["<CR>"]      = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                formatting = {
                    fields = {
                        cmp.ItemField.Menu,
                        cmp.ItemField.Abbr,
                        cmp.ItemField.Kind,
                    },
                    format = require("lspkind").cmp_format({
                        mode = "symbol_text",
                        with_text = true,
                        menu = {
                            nvim_lsp = "[LSP]",
                            luasnip  = "[SNIP]",
                            buffer   = "[BUF]",
                            path     = "[PATH]",
                            spell    = "[SPELL]",
                            calc     = "[CALC]",
                            emoji    = "[EMOJI]",
                            nvim_lua = "[API]",
                        },
                        before = require("tailwindcss-colorizer-cmp").formatter,
                    }),
                },
            })
        end,
        cond = not IS_USING_VSCODE,
    },
};

