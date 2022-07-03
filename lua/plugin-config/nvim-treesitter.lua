--[[
    https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects
    Built-in Textobjects
        @attribute.inner
        @attribute.outer
        @block.inner
        @block.outer
        @call.inner
        @call.outer
        @class.inner
        @class.outer
        @comment.outer
        @conditional.inner
        @conditional.outer
        @frame.inner
        @frame.outer
        @function.inner
        @function.outer
        @loop.inner
        @loop.outer
        @parameter.inner
        @parameter.outer
        @scopename.inner
        @statement.outer
]]
require 'nvim-treesitter.configs'.setup{
    ensure_installed = {"html", "css", "javascript", "typescript", "lua", "c", "cpp"},
    highlight = {
        enable = true,
    },

    -- text objects
    textobjects = {
        select = {
            enable = true,
            lookhead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@conditional.outer",
                ["ic"] = "@conditional.inner",
                ["cm"] = "@comment.outer",
                -- suffix "e" means execute
                ["ae"] = "@call.outer",
                ["ie"] = "@call.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",

                -- 實用度感覺較低           suffix "a" means argument
                -- ["aa"] = "@parameter.outer",
                -- ["ia"] = "@parameter.inner",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<Space>pl"] = "@parameter.inner",
                ["<Space>fj"] = "@function.outer",
            },
            swap_previous = {
                ["<Space>ph"] = "@parameter.inner",
                ["<Space>fk"] = "@function.outer",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]c"] = "@conditional.inner",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[c"] = "@conditional.inner",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
            },

        },
    },
};
