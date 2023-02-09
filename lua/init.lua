IS_USING_VSCODE = vim.fn.exists 'g:vscode' ~= 0;
vim.g.mapleader = " ";

require "option";
require "lazy-config";
require "keymap";
require "setup-colorscheme";
require "autocmd";

-- print("init.lua載入完成");
