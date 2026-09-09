return {
    -- markdown/html/latex/yaml previewer
    {
        "OXY2DEV/markview.nvim",
        -- plugin already lazy-loads itself internally
        lazy = false,
        keys = {
            { "<leader>mk", "<cmd>Markview<cr>", desc = "Toggle Markview Preview" },
        },
    },
};
