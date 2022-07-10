return require('packer').startup {
    function(use)
        -- Packer can manage itself as an optional plugin
        use 'wbthomason/packer.nvim';

        -- Color Scheme
        use 'rebelot/kanagawa.nvim';
        use 'sainnhe/sonokai';
        use 'sainnhe/gruvbox-material';
        use 'ellisonleao/gruvbox.nvim';

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
            tag = 'nightly', -- optional, updated every week. (see issue #1193)
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
            --config = function() require('nvim-surround').setup {}; end
        };

        -- telescope
        use {
            'nvim-telescope/telescope.nvim',
            requires = { 'nvim-lua/plenary.nvim' }
        };
        use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' };
    end,
    config = {
        -- 漂浮視窗功能
        display = {
            open_fn = require('packer.util').float,
        }
    },
};
