return {
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        cond = not IS_USING_VSCODE,
        opts = {
            sort_by = "case_sensitive",
            view = {
                -- adaptive_size = true
                width = 40,
            },
            filters = {
                exclude  = { "node_modules" },
            },
            git = {
                ignore = false,
            },
            update_focused_file = {
                enable = true,
                -- update_root = false,
                -- ignore_list = {},
            },
            on_attach = function (bufnr)
                -- from help "nvim-tree-mappings-default"
                local api = require('nvim-tree.api');
                api.config.mappings.default_on_attach(bufnr);
                vim.keymap.del('n', '<C-e>', { buffer = bufnr });
            end,
        },
        keys = {
            { "<leader>d", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle Tree [D]irectory" },
        },
    },
};
