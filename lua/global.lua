IS_USING_VSCODE = vim.fn.exists 'g:vscode' ~= 0;
EVENT = {
    FIND_THEME = "User FindTheme",
};
IS_MAC = vim.fn.has 'macunix' ~= 0;

local signs = {
    DiagnosticSignError = " ",
    DiagnosticSignWarn  = " ",
    DiagnosticSignInfo  = " ",
    DiagnosticSignHint  = " ",
};
for name, text in pairs(signs) do
    vim.fn.sign_define(name, { text = text, texthl = name, numhl = name });
end
vim.g.mapleader = " ";
