IS_USING_VSCODE = vim.fn.exists 'g:vscode' ~= 0;
vim.g.mapleader = " ";

require "option";
require "keymap";
require "plugins";

require "plugin-config/nvim-treesitter";
require "plugin-config.nvim-surround";
require "plugin-config.gitsigns";
require "plugin-config.lualine";

if IS_USING_VSCODE then
    -- print("detect vscode, stop plugin setup");
    return;
end

require "plugin-config.nvim-tree";
require "plugin-config.gruvbox-material";
require "plugin-config.bufferline";
require "plugin-config.nvim-cmp";
require "plugin-config.telescope";

require "lsp.setup";
require "luasnip.setup";
require "colorscheme";

-- print("init.lua載入完成");
