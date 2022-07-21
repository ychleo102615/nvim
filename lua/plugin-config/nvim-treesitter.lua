-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects
require('nvim-treesitter.configs').setup{
    ensure_installed = {"html", "css", "javascript", "typescript", "lua", "c", "cpp"},
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
};
