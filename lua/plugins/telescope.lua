return {
    -- telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = vim.fn.executable('make') == 1
            },
        },
        cmd = "Telescope",
        config = function()
            require('telescope').setup {
                -- https://github.com/nvim-telescope/telescope.nvim/pull/828
                defaults = {
                    mappings = {
                        n = {
                            ["d"] = "delete_buffer",
                            -- ["<C-h>"] = "which_key",
                        }
                    }
                },
                extensions = {
                    ['fzf'] = {
                        fuzzy                   = true,         -- false will only do exact matching
                        override_generic_sorter = true,         -- override the generic sorter
                        override_file_sorter    = true,         -- override the file sorter
                        case_mode               = "smart_case", -- or "ignore_case" or "respect_case"
                    },
                    ['ui-select'] = {
                        require("telescope.themes").get_cursor {
                            initial_mode = 'normal',
                            layout_config = { height = 0.25 },
                        }
                    },
                },
            };
            -- To get fzf loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require('telescope').load_extension('fzf');
            require('telescope').load_extension('ui-select');
        end,
    },
};
