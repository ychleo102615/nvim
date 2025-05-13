--[[
    學習資源
    http://yyq123.github.io/learn-vim/learn-vi-49-01-autocmd.html
]]

local tidyAutoGroup = vim.api.nvim_create_augroup("tidyCode", { clear = true, });

-- source: https://riptutorial.com/vim/example/26597/delete-trailing-spaces-in-a-file
vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    {
        -- pattern = { "*.lua" };
        -- command = "%s/\\s\\+$//e", -- need more esacpe char
        command = [[%s/\s\+$//e]],
        group   = tidyAutoGroup,
    }
);

-- 確保新行不會繼承註解
vim.api.nvim_create_autocmd(
    "BufEnter",
    {
        pattern = "*",
        callback = function()
            vim.opt.formatoptions:remove("o")
        end,
    }
);

-- Lsp自動設定keymap
vim.api.nvim_create_autocmd(
    "LspAttach",
    {
        pattern = "*",
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id);
            require("keymap.lsp").on_attach(client, args.buf);
            -- if client.name ~= "tailwindcss" then
            --     require("nvim-navbuddy").attach(client, args.buf);
            -- end
            -- print(vim.inspect(client));
            -- print(client.name .. " attached");
        end,
    }
);
