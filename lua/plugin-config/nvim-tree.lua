require('nvim-tree').setup {
    sort_by = "case_sensitive",
    renderer = {
        highlight_git = true,
        group_empty = true,
    },
    filters = {
        exclude = { "node_modules" },
    },
};
