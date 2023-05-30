IS_USING_VSCODE = vim.fn.exists 'g:vscode' ~= 0;
EVENT = {
    FIND_THEME = "User FindTheme",
};
IS_MAC = vim.fn.has 'macunix' ~= 0;

vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" });
vim.fn.sign_define("DiagnosticSignWarn",  { text = " ", texthl = "DiagnosticSignWarn" });
vim.fn.sign_define("DiagnosticSignInfo",  { text = " ", texthl = "DiagnosticSignInfo" });
vim.fn.sign_define("DiagnosticSignHint",  { text = "",  texthl = "DiagnosticSignHint" });
vim.g.mapleader = " ";
