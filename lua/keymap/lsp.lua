-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/keymaps.lua
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/format.lua
local function isNullLsSupported()
    local buf = vim.api.nvim_get_current_buf();
    local ft = vim.bo[buf].filetype;
    local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0;
    return have_nls;
end

return {
    setupKeymap = function()
        -- Mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        -- local opts = { noremap = true, silent = true }
        local function exd(tab)
            return vim.tbl_deep_extend("force", { noremap = true, silent = true }, tab);
        end

        vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, exd { desc = "Line Diagnostics" })
        vim.keymap.set('n', ']d',         vim.diagnostic.goto_next,  exd { desc = "Next Diagnostic" })
        vim.keymap.set('n', '[d',         vim.diagnostic.goto_prev,  exd { desc = "Prev Diagnostic" })
        vim.keymap.set('n', '<leader>cs', vim.diagnostic.setloclist, exd {})
        vim.keymap.set('n', '<leader>cl', "<cmd>LspInfo<cr>",        exd { desc = "Lsp Info" })
    end,
    on_attach = function(_, bufnr)
        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        -- local bufopts = { noremap = true, silent = true, buffer = bufnr }
        local function exd(tab)
            return vim.tbl_deep_extend("force", {
                noremap = true, silent = true, buffer = bufnr
            }, tab);
        end
        vim.keymap.set('n', 'gD',         vim.lsp.buf.declaration,             exd { desc = "Goto Declaration" })
        vim.keymap.set('n', 'gd',         vim.lsp.buf.definition,              exd { desc = "Goto Definition" })
        vim.keymap.set('n', 'K',          vim.lsp.buf.hover,                   exd { desc = "Hover" })
        vim.keymap.set('n', 'gi',         vim.lsp.buf.implementation,          exd { desc = "Implementation" })
        vim.keymap.set('n', 'gK',         vim.lsp.buf.signature_help,          exd { desc = "Signature" })
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,    exd { desc = "Add Workspace folder" })
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, exd { desc = "Remove Workspace folder" })
        vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, exd { desc = "List Workspace Folder" })
        vim.keymap.set('n', '<leader>D',  vim.lsp.buf.type_definition,         exd { desc = "Type Definition" })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,                  exd { desc = "Rename" })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,             exd { desc = "Code Action" })
        vim.keymap.set('n', 'gr',         vim.lsp.buf.references,              exd { desc = "References" })
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
        vim.keymap.set('n', '<leader>fm', function()
            vim.lsp.buf.format {
                async = true,
                filter = function(client)
                    -- isNullLsSupport XOR isUsingNullLs
                    return isNullLsSupported() == (client.name == 'null-ls');
                end,
            }
        end, exd { desc = "Format Document"})
    end,
};
