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
            view = {
                mappings = {
                    list = {
                        { key = "<C-e>", action = "" },
                    },
                },
            },
            filters = {
                exclude  = { "node_modules" },
            },
            git = {
                ignore = false,
            },
        },
        keys = {
            { "<leader>d", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle Tree [D]irectory" },
        },
    },
};
