return {
    -- Tree Sitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = "BufReadPost",
        keys = {
            { "<enter>", desc = "Increment selection" },
            { "<enter>", desc = "Increment selection",   mode = "x" },
            { "<bs>",    desc = "Schrink selection",     mode = "x" },
        },
        opts = {
            ensure_installed = { "html", "css", "javascript", "typescript", "lua", "c", "cpp", "go", "vue", "help", "cmake", "vim", "java", "python" },
            highlight = {
                -- enable = true,
                enable = not IS_USING_VSCODE,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection    = "<enter>",
                    node_incremental  = "<enter>",
                    scope_incremental = "<nop>",
                    node_decremental  = "<bs>",
                },
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
                        -- "c" 已被change佔用，改用 "s", means statement
                        ["as"] = "@conditional.outer",
                        ["is"] = "@conditional.inner",
                        -- suffix "q" means quote
                        ["iq"] = "@comment.inner",
                        ["aq"] = "@comment.outer",
                        -- suffix "e" means execute
                        ["ae"] = "@call.outer",
                        ["ie"] = "@call.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        -- suffix "a" means argument
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["ar"] = "@return.outer",
                        ["ir"] = "@return.inner",
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
                        ["]f"] = "@function.outer",
                        ["]s"] = "@conditional.inner",
                        ["]S"] = "@conditional.outer",
                        ["]q"] = "@comment.outer",
                        ["]a"] = "@parameter.inner",
                        ["]e"] = "@call.outer",
                        ["]r"] = "@return.outer",
                        ["]R"] = "@return.inner",
                    },
                    goto_next_end = {
                        ["]F"] = "@function.outer",
                    },
                    goto_previous_start = {
                        ["[f"] = "@function.outer",
                        ["[s"] = "@conditional.inner",
                        ["[S"] = "@conditional.outer",
                        ["[q"] = "@comment.outer",
                        ["[a"] = "@parameter.inner",
                        ["[e"] = "@call.outer",
                        ["[r"] = "@return.outer",
                        ["[R"] = "@return.inner",
                    },
                    goto_previous_end = {
                        ["[F"] = "@function.outer",
                    },
                },
            },
            playground = {
                enable          = true,
                disable         = {},
                updatetime      = 25, -- Debounced time for highlighting nodes in the playground from source code
                persist_queries = false, -- Whether the query persists across vim sessions
                keybindings     = {
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
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        event = "BufReadPost"
    },
    {
        'nvim-treesitter/playground',
        event = "BufReadPost",
        keys = {
            { "<leader>pg", "<cmd>TSPlaygroundToggle<cr>", desc = "Toggle Treesitter Playground" },
            { "<leader>pn", "<cmd>TSNodeUnderCursor<cr>",  desc = "Treesitter Node Info" },
        },
    },
};
