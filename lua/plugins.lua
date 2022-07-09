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
        use {'nvim-treesitter/nvim-treesitter-textobjects'};

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
            "onsails/lspkind-nvim"
        };

        -- cmp, config from: https://gist.github.com/mengwangk/e5b64dbbeadc81b0129f274908a7b692
        use {
            "hrsh7th/nvim-cmp",
            requires = {
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-nvim-lsp",
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-calc',
                'hrsh7th/cmp-nvim-lua',
                'hrsh7th/cmp-emoji',
                'f3fora/cmp-spell',
                "saadparwaiz1/cmp_luasnip"
            }
        };
    end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        }
    },
};
