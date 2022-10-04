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
        use "cpea2506/one_monokai.nvim";

        -- Tree Sitter
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate'
        };
        use 'nvim-treesitter/nvim-treesitter-textobjects';
        use 'nvim-treesitter/playground';

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
            'akinsho/bufferline.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
        };

        -- lsp config
        use {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            'neovim/nvim-lspconfig',
            'williamboman/nvim-lsp-installer',
            'onsails/lspkind-nvim'
        };

        -- outline
        use 'simrat39/symbols-outline.nvim';

        -- cmp, config from: https://gist.github.com/mengwangk/e5b64dbbeadc81b0129f274908a7b692
        use 'L3MON4D3/LuaSnip';
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
        use 'kylechui/nvim-surround';

        -- telescope
        use {
            'nvim-telescope/telescope.nvim',
            requires = { 'nvim-lua/plenary.nvim' }
        };
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' };
        use 'nvim-telescope/telescope-ui-select.nvim';

        -- git
        use 'lewis6991/gitsigns.nvim';

        -- editing
        use 'junegunn/vim-easy-align';
        use 'rmagatti/alternate-toggler';

        -- status line
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        };

        -- comment
        use {
            "danymat/neogen",
            requires = "nvim-treesitter/nvim-treesitter",
            -- Uncomment next line if you want to follow only stable versions
            tag = "*"
        };
        use 'numToStr/Comment.nvim';

        -- go
        use {
            'fatih/vim-go',
            -- run = ':GoUpdateBinaries',
            -- run = function()
            --     vim.cmd [[GoUpdateBinaries]];
            --     vim.g.go_fmt_autosave = false;
            --     vim.api.nvim_exec [[let g:go_fmt_autosave = 0]];
            -- end,
            -- ft  = 'go',
        };
    end,
    config = {
        -- 漂浮視窗功能
        display = {
            open_fn = require('packer.util').float,
        }
    },
};
