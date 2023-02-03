return {
    {
        'ellisonleao/gruvbox.nvim',
        lazy = true,
        config = {
            -- https://github.com/ellisonleao/gruvbox.nvim/blob/aee207e1ae55c44bd6a23c1a85e5e17939e3835b/lua/gruvbox/groups.lua
            bold = false,
            contrast = "hard",
            overrides = {
                GitSignsCurrentLineBlame = { link = "GruvboxBg4" },
                GitSignsChange           = { link = "GruvboxBlueSign" },
            },
        }
    },
    {
        'ayu-theme/ayu-vim',
        lazy = true,
        config = function()
            vim.g.ayucolor = "dark"
        end
    },
    { 'rebelot/kanagawa.nvim', lazy = true },
    { 'sainnhe/sonokai', lazy = true },
    { 'sainnhe/gruvbox-material', lazy = true },
    { 'olimorris/onedarkpro.nvim', lazy = true },
    { 'jdsimcoe/abstract.vim', lazy = true },
    { 'tlhr/anderson.vim', lazy = true },
    { 'romainl/Apprentice', lazy = true },
    { 'ajmwagar/vim-deus', lazy = true },
    { 'wadackel/vim-dogrun', lazy = true },
    { 'romainl/flattened', lazy = true },
    { 'rakr/vim-one', lazy = true },
    { 'sonph/onehalf', lazy = true },
    { 'sts10/vim-pink-moon', lazy = true },
    { 'junegunn/seoul256.vim', lazy = true },
    { 'AlessandroYorba/Sierra', lazy = true },
    { 'rakr/vim-two-firewatch', lazy = true },
    { 'sainnhe/everforest', lazy = true },
    { 'cpea2506/one_monokai.nvim', lazy = true },
};
