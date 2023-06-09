return {
    -- Tree
    {
        'nvim-neo-tree/neo-tree.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        cond = not IS_USING_VSCODE,
        opts = {
            filesystem = {
                filtered_items = {
                    visible = true, -- when true, they will just be displayed differently than normal items
                    always_show = {
                        -- remains visible even if other settings would normally hide it
                        ".gitignored",
                    },
                    never_show = {
                        -- remains hidden even if visible is toggled to true, this overrides always_show
                        ".DS_Store",
                    },
                },
                follow_current_file = true,
            },
            window = {
                mappings = {
                    ["<bs>"] = "close_node",
                }
            },
            source_selector = {
                winbar = true,
                -- statusline = true
            }
        },
        keys = {
            { "<leader>e",  "<cmd>NeoTreeRevealToggle<cr>",  desc = "Toggle N[E]o Tree" },
        }
    },
};
