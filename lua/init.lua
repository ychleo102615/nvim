require "option";
require "keymap";
require "plugins";

require "plugin-config/nvim-treesitter";
require "plugin-config.nvim-surround";

if vim.fn.exists 'g:vscode' ~= 0 then return; end

require "plugin-config.nvim-tree";
require "plugin-config.gruvbox-material";
require "plugin-config.bufferline";
require "plugin-config.nvim-cmp";
require "plugin-config.telescope";
require "plugin-config.gitsigns";

require "lsp/setup";

local schemeChoices = {
    "kanagawa",
    "gruvbox-material",
    "gruvbox",
};
vim.cmd("colorscheme " .. schemeChoices[3]);

-- print("init.lua載入完成");
