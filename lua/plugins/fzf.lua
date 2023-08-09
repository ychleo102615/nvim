return {
    {
        "junegunn/fzf.vim",
        dependencies = {
            {
                "junegunn/fzf",
                build = ":call fzf#install()",
                keys = {
                    { "<leader>fz", "<cmd>FZF<cr>", mode = {"n"}, desc = "FZF" },
                },
            },
        },
    },
};
