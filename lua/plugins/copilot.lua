if IS_USING_VSCODE then
    return;
end
return {
    "github/copilot.vim",
    event = "BufReadPost",
    keys = {
        {'<C-D>',  '<Plug>(copilot-dismiss)',  desc = 'Copilot Dismiss',  mode = 'i'},
        {'<C-]>',  '<Plug>(copilot-next)',     desc = 'Copilot Next',     mode = 'i'},
        {'<C-[>',  '<Plug>(copilot-previous)', desc = 'Copilot Previous', mode = 'i'},
        {'<C-\\>', '<Plug>(copilot-suggest)',  desc = 'Copilot Suggest',  mode = 'i'},
    },
};
