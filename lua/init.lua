require "option";
require "keymap";
require "plugins";

require "plugin-config/nvim-treesitter";
require "plugin-config/nvim-tree";
require "plugin-config/gruvbox-material";
require "plugin-config/bufferline";

local schemeChoices = {
    "kanagawa",
    "gruvbox-material",
    "gruvbox",
};
vim.cmd("colorscheme " .. schemeChoices[3]);

-- print("init.lua載入完成");
