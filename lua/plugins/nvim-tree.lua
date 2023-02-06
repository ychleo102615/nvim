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
            renderer = {
                highlight_git = true,
                group_empty   = true,
            },
            filters = {
                exclude  = { "node_modules" },
            },
            git = {
                ignore = false,
            },
        },
    },
};
