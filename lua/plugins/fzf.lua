return {
    {
        "junegunn/fzf.vim",
        enabled = false,
        dependencies = {
            {
                "junegunn/fzf",
                build = ":call fzf#install()",
            },
        },
        keys = {
            { "<leader>fz", "<cmd>Files<cr>",  mode = {"n"}, desc = "fzf Files" },
            { "<leader>fg", "<cmd>Rg<cr>",     mode = {"n"}, desc = "fzf Rg" },
            { "<C-/>",      "<cmd>BLines<cr>", mode = {"n"}, desc = "fzf Blines" },
        },
    },
};
