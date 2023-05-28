return {
    -- Tree
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        cond = not IS_USING_VSCODE,
        opts = {
            sort_by = "case_sensitive",
            filters = {
                exclude  = { "node_modules" },
            },
            git = {
                ignore = false,
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
