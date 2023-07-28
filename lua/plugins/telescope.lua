if IS_USING_VSCODE then
    print("[NVIM] Skip telescope");
    return {};
end

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
                            layout_config = { height = 0.3 },
                        }
                    },
                },
            };
            -- To get fzf loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require('telescope').load_extension('fzf');
            require('telescope').load_extension('ui-select');
        end,
        keys = {
            { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = "Find File" },
            { '<leader>fs', '<cmd>Telescope live_grep<cr>',  desc = "Find String" },
            { '<leader>fh', '<cmd>Telescope help_tags<cr>',  desc = "Find Helps" },
            { '<leader>fk', '<cmd>Telescope keymaps<cr>',    desc = "Find Keymaps" },
            { '<leader>fr', '<cmd>Telescope registers <cr>', desc = "Find Registers" },
            { '<leader>fm', '<cmd>Telescope marks <cr>',     desc = "Find Registers" },
            {
                '<leader>fu',
                function()
                    local builtin = require('telescope.builtin');
                    local themes  = require('telescope.themes');
                    builtin.buffers(themes.get_ivy {
                        layout_config = {
                            prompt_position = 'bottom',
                        },
                    });
                end,
                desc = "Find B[U]ffers"
            },
            {
                '<leader>ft',
                function()
                    vim.cmd("doautocmd " .. EVENT.FIND_THEME); -- send event
                    require("telescope.builtin").colorscheme { enable_preview = true };
                end,
                desc = "Find Themes"
            },
            { '<leader>gs', '<Cmd>Telescope git_status initial_mode=normal<CR>',   desc = "Git Status"},
            { '<leader>gc', '<Cmd>Telescope git_commits initial_mode=normal<CR>',  desc = "Git Commits" },
            { '<leader>gf', '<Cmd>Telescope git_bcommits initial_mode=normal<CR>', desc = "Git Buffer Commits" },
            { '<leader>gb', function()
                local builtin = require('telescope.builtin');
                local themes  = require('telescope.themes');
                builtin.git_branches(themes.get_ivy {
                    layout_config = {
                        mirror = false,
                        prompt_position = 'bottom',
                    },
                    initial_mode = 'normal',
                });
            end, desc = "Git Branches" },
        },
    },
};
