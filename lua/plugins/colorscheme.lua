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
        event = EVENT.FIND_THEME,
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
        event = EVENT.FIND_THEME,
        config = function()
            vim.g.ayucolor = "dark"
        end
    },
    {
        'junegunn/seoul256.vim',
        event = EVENT.FIND_THEME,
        config = function()
            vim.g.seoul256_background = 234;
        end
    },
    {
        'sainnhe/sonokai',
        event = EVENT.FIND_THEME,
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
        event = EVENT.FIND_THEME,
        config = function()
            vim.g.everforest_background = "hard";
            vim.g.everforest_ui_contrast = "high";
        end
    },
    { 'rebelot/kanagawa.nvim',     event = EVENT.FIND_THEME },
    { 'sainnhe/gruvbox-material',  event = EVENT.FIND_THEME },
    { 'olimorris/onedarkpro.nvim', event = EVENT.FIND_THEME },
    { 'jdsimcoe/abstract.vim',     event = EVENT.FIND_THEME },
    { 'tlhr/anderson.vim',         event = EVENT.FIND_THEME },
    { 'romainl/Apprentice',        event = EVENT.FIND_THEME },
    { 'ajmwagar/vim-deus',         event = EVENT.FIND_THEME },
    { 'wadackel/vim-dogrun',       event = EVENT.FIND_THEME },
    { 'romainl/flattened',         event = EVENT.FIND_THEME },
    { 'rakr/vim-one',              event = EVENT.FIND_THEME },
    { 'sonph/onehalf',             event = EVENT.FIND_THEME },
    { 'sts10/vim-pink-moon',       event = EVENT.FIND_THEME },
    { 'AlessandroYorba/Sierra',    event = EVENT.FIND_THEME },
    { 'rakr/vim-two-firewatch',    event = EVENT.FIND_THEME },
    { 'cpea2506/one_monokai.nvim', event = EVENT.FIND_THEME },
    {
        "folke/tokyonight.nvim",
        event = EVENT.FIND_THEME,
        opts = { style = "moon" },
    },
    { 'EdenEast/nightfox.nvim',      event = EVENT.FIND_THEME  },
    { 'projekt0n/github-nvim-theme', event = EVENT.FIND_THEME, tag = 'v0.0.7' },
    { 'savq/melange-nvim',           event = EVENT.FIND_THEME  },
    { "catppuccin/nvim",             event = EVENT.FIND_THEME  },
    { "embark-theme/vim",            event = EVENT.FIND_THEME  },
    { "LunarVim/lunar.nvim",         event = EVENT.FIND_THEME  },
};
