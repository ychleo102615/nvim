return {
    {
        "junegunn/fzf.vim",
        dependencies = {
            {
                "junegunn/fzf",
                build = ":call fzf#install()",
                keys = {
                    { "<leader>fz", "<cmd>Files<cr>", mode = {"n"}, desc = "fzf Files" },
                    { "<leader>fg", "<cmd>Rg<cr>",    mode = {"n"}, desc = "fzf Rg" },
                },
            },
        },
    },
};
