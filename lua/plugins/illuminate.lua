return {
    "RRethy/vim-illuminate",
    event = "BufEnter",
    enabled = not IS_USING_VSCODE,
    config = function()
        require('illuminate').configure {
            filetypes_denylist = {
                "alpha",
                "NvimTree",
                "lazy",
                "Outline",
                "toggleterm",
                "DressingSelect",
                "TelescopePrompt",
            },
        };
    end,
};
