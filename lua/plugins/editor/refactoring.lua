-- local function setup_keymap()
--     local default_opts = { noremap = true, silent = true, expr = false };
--     local map = function(mode, lfs, rfs, opts)
--         opts = vim.tbl_deep_extend("force", default_opts, opts);
--         return vim.keymap.set(mode, lfs, rfs, opts);
--     end;
--     local refactoring = require('refactoring');
--
--     -- Remaps for the refactoring operations currently offered by the plugin
--     map("v",  "<leader>re",  function() refactoring.refactor('Extract Function') end,         { desc = "Extract Function" })
--     map("v",  "<leader>rf",  function() refactoring.refactor('Extract Function To File') end, { desc = "Extract Function To File" })
--     map("v",  "<leader>rv",  function() refactoring.refactor('Extract Variable') end,         { desc = "Extract Variable" })
--     map("v",  "<leader>ri",  function() refactoring.refactor('Inline Variable') end,          { desc = "Inline Variable" })
--     -- Extract block doesn't need visual mode
--     map("n",  "<leader>rb",  function() refactoring.refactor('Extract Block') end,            { desc = "Extract Block" })
--     map("n",  "<leader>rbf", function() refactoring.refactor('Extract Block To File') end,    { desc = "Extract Block To File" })
--     -- Inline variable can also pick up the identifier currently under the cursor without visual mode
--     map("n",  "<leader>ri",  function() refactoring.refactor('Inline Variable') end,          { desc = "Inline Variable" })
--     map( "v", "<leader>rr",  function() refactoring.select_refactor() end,                    { desc = "Select Refactor" })
-- end

local function getPlugin()
    return require('refactoring');
end

local default_opts = { noremap = true, silent = true, expr = false };
local function exd_dft_opts(tab)
    return vim.tbl_deep_extend("force", tab, default_opts);
end

return {
    -- Refactor
    {
       "ThePrimeagen/refactoring.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
        },
        keys = {
            -- Remaps for the refactoring operations currently offered by the plugin
            exd_dft_opts { "<leader>re",  function() getPlugin().refactor('Extract Function') end,         desc = "Extract Function",         mode = "v" },
            exd_dft_opts { "<leader>rf",  function() getPlugin().refactor('Extract Function To File') end, desc = "Extract Function To File", mode = "v" },
            exd_dft_opts { "<leader>rv",  function() getPlugin().refactor('Extract Variable') end,         desc = "Extract Variable",         mode = "v" },
            exd_dft_opts { "<leader>ri",  function() getPlugin().refactor('Inline Variable') end,          desc = "Inline Variable",          mode = "v" },
            -- Extract block doesn't need visual mode
            exd_dft_opts { "<leader>rb",  function() getPlugin().refactor('Extract Block') end,            desc = "Extract Block",            mode = "n" },
            exd_dft_opts { "<leader>rbf", function() getPlugin().refactor('Extract Block To File') end,    desc = "Extract Block To File",    mode = "n" },
            -- Inline variable can also pick up the identifier currently under the cursor without visual mode
            exd_dft_opts { "<leader>ri",  function() getPlugin().refactor('Inline Variable') end,          desc = "Inline Variable",          mode = "n" },

            exd_dft_opts { "<leader>rr",  function() getPlugin().select_refactor() end,                    desc = "Select Refactor",          mode = "v" },
        },
        -- config = setup_keymap,
        config = true,
    },
};
