return require('packer').startup {
    function(use)
        -- Packer can manage itself as an optional plugin
        use 'wbthomason/packer.nvim';

        -- Color Scheme
        use 'rebelot/kanagawa.nvim';
        use 'sainnhe/sonokai';
        use 'sainnhe/gruvbox-material';
        use 'ellisonleao/gruvbox.nvim';
        use 'olimorris/onedarkpro.nvim';
        use 'jdsimcoe/abstract.vim';
        use 'AlessandroYorba/Alduin';
        use 'tlhr/anderson.vim';
        use 'ayu-theme/ayu-vim';
        use 'romainl/Apprentice';
        use 'haystackandroid/carbonized';
        use 'ajmwagar/vim-deus';
        use 'wadackel/vim-dogrun';
        use 'romainl/flattened';
        use 'rakr/vim-one';
        use 'sonph/onehalf';
        use 'sts10/vim-pink-moon';
        use 'junegunn/seoul256.vim';
        use 'AlessandroYorba/Sierra';
        use 'rakr/vim-two-firewatch';
        use 'sainnhe/everforest';

        -- Tree Sitter
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate'
        };
        use { 'nvim-treesitter/nvim-treesitter-textobjects' };

        -- Tree
        use {
            'kyazdani42/nvim-tree.lua',
            requires = {
                'kyazdani42/nvim-web-devicons', -- optional, for file icons
            },
            -- tag = 'nightly', -- optional, updated every week. (see issue #1193)
        };

        -- buffer line
        use {
            'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons',
        };

        -- lsp config
        use {
            'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer',
            'onsails/lspkind-nvim'
        };

        -- cmp, config from: https://gist.github.com/mengwangk/e5b64dbbeadc81b0129f274908a7b692
        use { 'L3MON4D3/LuaSnip' };
        use {
            'hrsh7th/nvim-cmp',
            requires = {
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-nvim-lua',
                'hrsh7th/cmp-calc',
                'hrsh7th/cmp-emoji',
                'saadparwaiz1/cmp_luasnip',
                'f3fora/cmp-spell',
            }
        };

        -- motion
        use 'ggandor/lightspeed.nvim';

        -- surround
        -- https://github.com/kylechui/nvim-surround
        -- https://github.com/tpope/vim-surround
        use {
            'kylechui/nvim-surround',
            -- config = function() require('nvim-surround').setup {}; end
        };

        -- telescope
        use {
            'nvim-telescope/telescope.nvim',
            requires = { 'nvim-lua/plenary.nvim' }
        };
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' };
        use {'nvim-telescope/telescope-ui-select.nvim' };

        -- git
        use { 'lewis6991/gitsigns.nvim', };

        -- editing
        use 'junegunn/vim-easy-align';
        use 'rmagatti/alternate-toggler';

        -- status line
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        };
    end,
    config = {
        -- ??????????????????
        display = {
            open_fn = require('packer.util').float,
        }
    },
};
