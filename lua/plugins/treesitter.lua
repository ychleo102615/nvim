return {
    -- Tree Sitter
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        build = ':TSUpdate',
        -- main branch does not support lazy-loading
        lazy = false,
        keys = {
            -- playground plugin is gone; built-ins replace it
            { "<leader>pg", "<cmd>InspectTree<cr>", desc = "Toggle Treesitter Inspector" },
            { "<leader>pn", "<cmd>Inspect<cr>",      desc = "Inspect Highlight Group Under Cursor" },
            -- incremental_selection is gone (upstream: no replacement); recreated via
            -- core's an node text object (Neovim 0.12+). an is a plain keymap, not
            -- hardcoded like iw/ap, so remap=true is required for it to resolve.
            -- (no shrink/<BS> binding: vim.treesitter._select.select_child has a
            -- reproducible off-by-one right after a grow, overshooting bigger before
            -- it starts shrinking correctly on later presses -- it's private/unstable
            -- API for a reason.)
            --
            -- <CR> here is a global keymap, which shadows quickfix's (and help's,
            -- netrw's, ...) built-in <CR> behavior: those aren't real keymaps, just
            -- the default Normal-mode action for special buffers, so any user
            -- mapping on <CR> silently wins. Guard on buftype == "" (a real file
            -- buffer) and otherwise replay <CR> unmapped ('n' flag) so the
            -- buffer-specific default still runs.
            {
                "<CR>",
                function()
                    if vim.bo.buftype ~= "" then
                        return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
                    end
                    vim.api.nvim_feedkeys("van", "m", false)
                end,
                mode = "n",
                desc = "Select treesitter node under cursor",
            },
            {
                "<CR>",
                function()
                    if vim.bo.buftype ~= "" then
                        return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
                    end
                    vim.api.nvim_feedkeys("an", "m", false)
                end,
                mode = "x",
                desc = "Expand selection to parent node",
            },
        },
        config = function()
            local ensure_installed = {
                "html", "css", "javascript", "typescript", "lua", "c", "cpp",
                "vue", "cmake", "vim", "java", "python",
                "markdown", "markdown_inline",
            }

            require("nvim-treesitter").install(ensure_installed)

            -- highlight + auto-install for any other filetype opened later
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("user-treesitter-highlight", { clear = true }),
                callback = function(ev)
                    local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
                    if not require("nvim-treesitter.parsers")[lang] then
                        return
                    end
                    if not vim.tbl_contains(require("nvim-treesitter.config").get_installed("parsers"), lang) then
                        require("nvim-treesitter").install({ lang }):wait(300000)
                    end
                    if not IS_USING_VSCODE then
                        vim.treesitter.start()
                    end
                end,
            })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        event = "BufReadPost",
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = { lookahead = true },
                move = { set_jumps = true },
            })

            local select = require("nvim-treesitter-textobjects.select")
            local move = require("nvim-treesitter-textobjects.move")
            local swap = require("nvim-treesitter-textobjects.swap")

            -- text objects: select
            local select_keymaps = {
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                -- "c" 已被change佔用，改用 "s", means statement
                ["as"] = "@conditional.outer",
                ["is"] = "@conditional.inner",
                -- suffix "q" means quote
                ["im"] = "@comment.inner",
                ["am"] = "@comment.outer",
                -- suffix "e" means execute
                ["ae"] = "@call.outer",
                ["ie"] = "@call.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                -- suffix "a" means argument
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
            }
            for key, query in pairs(select_keymaps) do
                vim.keymap.set({ "x", "o" }, key, function()
                    select.select_textobject(query, "textobjects")
                end)
            end

            -- text objects: swap
            vim.keymap.set("n", "<leader>pl", function() swap.swap_next("@parameter.inner") end)
            vim.keymap.set("n", "<leader>rl", function() swap.swap_next("@parameter.inner") end)
            vim.keymap.set("n", "<leader>ph", function() swap.swap_previous("@parameter.inner") end)
            vim.keymap.set("n", "<leader>rh", function() swap.swap_previous("@parameter.inner") end)

            -- text objects: move
            local goto_next_start = {
                ["]f"] = "@function.outer",
                ["]s"] = "@conditional.inner",
                ["]S"] = "@conditional.outer",
                ["]m"] = "@comment.outer",
                ["]a"] = "@parameter.inner",
                ["]e"] = "@call.outer",
            }
            for key, query in pairs(goto_next_start) do
                vim.keymap.set({ "n", "x", "o" }, key, function() move.goto_next_start(query, "textobjects") end)
            end

            local goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[s"] = "@conditional.inner",
                ["[S"] = "@conditional.outer",
                ["[m"] = "@comment.outer",
                ["[a"] = "@parameter.inner",
                ["[e"] = "@call.outer",
            }
            for key, query in pairs(goto_previous_start) do
                vim.keymap.set({ "n", "x", "o" }, key, function() move.goto_previous_start(query, "textobjects") end)
            end

            vim.keymap.set({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer", "textobjects") end)
        end,
    },
    {
        "mtdl9/vim-log-highlighting",
        ft = { "log" },
    }
};
