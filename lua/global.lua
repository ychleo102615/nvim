IS_USING_VSCODE = vim.fn.exists 'g:vscode' ~= 0;
EVENT = {
    FIND_THEME = "User FindTheme",
};
IS_MAC = vim.fn.has 'macunix' ~= 0;

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
            [vim.diagnostic.severity.HINT]  = " ",
        },
    },
    underline = true,
})

vim.g.mapleader = " ";
