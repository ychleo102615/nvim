IS_USING_VSCODE = vim.fn.exists 'g:vscode' ~= 0;
vim.g.mapleader = " ";

require "lazy-config";
require "option";
require "keymap";
require "setup-colorscheme";

require "plugin-config.nvim-surround";
require "plugin-config.gitsigns";
require "plugin-config.lualine";
require "plugin-config.refactoring";

if IS_USING_VSCODE then
    -- print("detect vscode, stop plugin setup");
    return;
end

require "plugin-config.gruvbox-material";
require "plugin-config.bufferline";
require "plugin-config.telescope";
require "plugin-config.symbols-outline";
require "plugin-config.vim-go";

require "luasnip.setup";
require "autocmd";

-- print("init.lua載入完成");
