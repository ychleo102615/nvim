return {
    -- Tree
    {
        'nvim-neo-tree/neo-tree.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        cond = true,
        -- cond = not IS_USING_VSCODE,
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
            },
        },
        config = function(_, opts)
            vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" });
            vim.fn.sign_define("DiagnosticSignWarn",  { text = " ", texthl = "DiagnosticSignWarn" });
            vim.fn.sign_define("DiagnosticSignInfo",  { text = " ", texthl = "DiagnosticSignInfo" });
            vim.fn.sign_define("DiagnosticSignHint",  { text = "",  texthl = "DiagnosticSignHint" });
            require("neo-tree").setup(opts);
        end,
        keys = {
            { "<leader>e",  "<cmd>NeoTreeRevealToggle<cr>",  desc = "Toggle N[E]o Tree" },
        }
    },
};
