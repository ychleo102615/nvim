local schemeChoices = {
    "kanagawa",         -- visual mode not clear
    "gruvbox-material", -- resereved words not so distinctive
    "gruvbox",          -- virtual text not clear
    "onedarkpro",       -- visual mode not clear
    "abstract",

    "alduin",
    "anderson",
    "ayu",
    "apprentice",
    "deus", -- declaration too red

    "one",
    "pink-moon",
    "seoul256",
    "sierra",
    "sonokai";

    "yellow-moon",
    "orange-moon",
    "two-filewatch",
    "everforest",
    "one_monokai",
};

vim.g.seoul256_background = 234;
local sonokaiStyles = {
    "default", "atlantis", "andromeda", "shusia", "maia", "espresso",
};
vim.g.sonokai_style = sonokaiStyles[6];
vim.g.sonokai_enable_italic = true;
vim.g.everforest_background = "hard";
vim.g.everforest_ui_contrast = "high";

vim.cmd("colorscheme " .. schemeChoices[3]);
-- vim.cmd("colorscheme " .. schemeChoices[20]);
