local function gruvbox_setup()
    -- https://github.com/sainnhe/gruvbox-material/blob/master/doc/gruvbox-material.txt
    vim.cmd [[
        " Important!!
        if has('termguicolors')
            set termguicolors
        endif
        " For dark version.
        set background=dark
        " For light version.
        " set background=light
        " Set contrast.
        " This configuration option should be placed before `colorscheme gruvbox-material`.
        " Available values: 'hard', 'medium'(default), 'soft'
        let g:gruvbox_material_background = 'soft'
        " For better performance
        let g:gruvbox_material_better_performance = 1
    ]];
end

return {
    {
        'ellisonleao/gruvbox.nvim',
        lazy = true,
        opts = {
            -- https://github.com/ellisonleao/gruvbox.nvim/blob/aee207e1ae55c44bd6a23c1a85e5e17939e3835b/lua/gruvbox/groups.lua
            bold = false,
            contrast = "hard",
            overrides = {
                GitSignsCurrentLineBlame = { link = "GruvboxBg4" },
                GitSignsChange           = { link = "GruvboxBlueSign" },
            },
            config = gruvbox_setup,
        }
    },
    {
        'ayu-theme/ayu-vim',
        lazy = true,
        config = function()
            vim.g.ayucolor = "dark"
        end
    },
    {
        'junegunn/seoul256.vim',
        lazy = true,
        config = function()
            vim.g.seoul256_background = 234;
        end
    },
    {
        'sainnhe/sonokai',
        lazy = true,
        config = function()
            local sonokaiStyles = {
                "default", "atlantis", "andromeda", "shusia", "maia", "espresso",
            };
            vim.g.sonokai_style = sonokaiStyles[6];
            vim.g.sonokai_enable_italic = true;
        end,
    },
    {
        'sainnhe/everforest',
        lazy = true,
        config = function()
            vim.g.everforest_background = "hard";
            vim.g.everforest_ui_contrast = "high";
        end
    },
    { 'rebelot/kanagawa.nvim',     lazy = true },
    { 'sainnhe/gruvbox-material',  lazy = true },
    { 'olimorris/onedarkpro.nvim', lazy = true },
    { 'jdsimcoe/abstract.vim',     lazy = true },
    { 'tlhr/anderson.vim',         lazy = true },
    { 'romainl/Apprentice',        lazy = true },
    { 'ajmwagar/vim-deus',         lazy = true },
    { 'wadackel/vim-dogrun',       lazy = true },
    { 'romainl/flattened',         lazy = true },
    { 'rakr/vim-one',              lazy = true },
    { 'sonph/onehalf',             lazy = true },
    { 'sts10/vim-pink-moon',       lazy = true },
    { 'AlessandroYorba/Sierra',    lazy = true },
    { 'rakr/vim-two-firewatch',    lazy = true },
    { 'cpea2506/one_monokai.nvim', lazy = true },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = { style = "moon" },
    },
    -- https://github.com/EdenEast/nightfox.nvim
    { 'EdenEast/nightfox.nvim', lazy = true },
    -- https://github.com/projekt0n/github-nvim-theme
    { 'projekt0n/github-nvim-theme', lazy = true, tag = 'v0.0.7' },
    { 'savq/melange-nvim', lazy = true },
    -- colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
    { "catppuccin/nvim", lazy = true },
    { "embark-theme/vim", lazy = true },
};
