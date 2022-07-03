return require('packer').startup(function()
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
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    };

    -- buffer line
    use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'};
end);
