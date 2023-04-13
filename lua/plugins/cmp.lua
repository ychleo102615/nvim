if IS_USING_VSCODE then
    print("[NVIM] Skip cmp");
    return {};
end

local function setupLuaSnip()
    require("luasnip.loaders.from_vscode").lazy_load { paths = "./lua/luasnip/snippets" };
    -- snipmate from: https://github.com/honza/vim-snippets
    require("luasnip.loaders.from_snipmate").lazy_load { paths = "./lua/luasnip/snipmate/snippets" };

    local ls      = require("luasnip");
    local s       = ls.snippet;
    local sn      = ls.snippet_node;
    local isn     = ls.indent_snippet_node;
    local t       = ls.text_node;
    local i       = ls.insert_node;
    local f       = ls.function_node;
    local c       = ls.choice_node;
    local d       = ls.dynamic_node;
    local r       = ls.restore_node;
    local events  = require("luasnip.util.events");
    local ai      = require("luasnip.nodes.absolute_indexer");
    local fmt     = require("luasnip.extras.fmt").fmt;
    local m       = require("luasnip.extras").m;
    local lambda  = require("luasnip.extras").l;
    local postfix = require("luasnip.extras.postfix").postfix;

    -- Just learning purpose. from luasnip/util/environ.lua
    local function FILENAME_BASE()
        return vim.fn.expand("%:t:s?\\.[^\\.]\\+$??")
    end

    -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
    ls.add_snippets("all", {
        s("ternary", {
            i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
        }),
    });
    ls.add_snippets("lua", {
        s("ternary", {
            i(1, "cond"), t(" and "), i(2, "then"), t(" or "), i(3, "else")
        }),
    });
    ls.add_snippets("typescript", {});

    ls.filetype_extend("all", { "_" });
end
return {
    -- cmp, config from: https://gist.github.com/mengwangk/e5b64dbbeadc81b0129f274908a7b692
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        lazy = true, -- load when nvim-cmp loaded
        config = setupLuaSnip,
        keys = {
            { "<C-f>", function() require('luasnip').jump(1) end,  mode = { "i", "s" }, desc = "Jump Next" },
            { "<C-b>", function() require('luasnip').jump(-1) end, mode = { "i", "s" }, desc = "Jump Prev" },
        },
    },
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
            "L3MON4D3/LuaSnip",
        },
        event = "InsertEnter",
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
            });
        end,
        cond = not IS_USING_VSCODE,
    },
};

