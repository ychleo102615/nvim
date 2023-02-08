IS_USING_VSCODE = vim.fn.exists 'g:vscode' ~= 0;
vim.g.mapleader = " ";

require "option";
require "lazy-config";
require "keymap";
require "setup-colorscheme";

require "plugin-config.nvim-surround";
require "plugin-config.refactoring";

if IS_USING_VSCODE then
    -- print("detect vscode, stop plugin setup");
    return;
end

require "plugin-config.gruvbox-material";
require "plugin-config.telescope";

require "autocmd";

-- print("init.lua載入完成");
