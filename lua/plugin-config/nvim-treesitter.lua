-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects
require('nvim-treesitter.configs').setup{
    ensure_installed = {"html", "css", "javascript", "typescript", "lua", "c", "cpp", "go" },
    highlight = {
        -- enable = true,
        enable = not IS_USING_VSCODE,
    },
    -- text objects
    textobjects = {
        select = {
            enable = true,
            lookhead = true,
            keymaps = {
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                -- c 已被change佔用，改用 s
                ["as"] = "@conditional.outer",
                ["is"] = "@conditional.inner",
                -- suffix "q" means quote
                ["q"] = "@comment.outer",
                -- suffix "e" means execute
                ["ae"] = "@call.outer",
                ["ie"] = "@call.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",

                -- 實用度感覺較低           suffix "a" means argument
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<Space>pl"] = "@parameter.inner",
                -- ["<Space>fj"] = "@function.outer",
            },
            swap_previous = {
                ["<Space>ph"] = "@parameter.inner",
                -- ["<Space>fk"] = "@function.outer",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]f"] = "@function.outer",
                ["]s"] = "@conditional.inner",
                ["]S"] = "@conditional.outer",
                ["]q"] = "@comment.outer",
                ["]a"] = "@parameter.outer",
            },
            goto_next_end = {
                ["]F"] = "@function.outer",
            },
            goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[s"] = "@conditional.inner",
                ["[S"] = "@conditional.outer",
                ["[q"] = "@comment.outer",
                ["[a"] = "@parameter.outer",
            },
            goto_previous_end = {
                ["[F"] = "@function.outer",
            },

        },
    },
    playground = {
        enable          = true,
        disable         = {},
        updatetime      = 25,    -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor       = 'o',
            toggle_hl_groups          = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes    = 'a',
            toggle_language_display   = 'I',
            focus_language            = 'f',
            unfocus_language          = 'F',
            update                    = 'R',
            goto_node                 = '<cr>',
            show_help                 = '?',
        },
    },
};
