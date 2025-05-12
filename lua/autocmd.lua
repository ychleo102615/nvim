-- 目前似乎autocmd似乎不影響vscode
-- if IS_USING_VSCODE then
--     return;
-- end

--[[
    http://yyq123.github.io/learn-vim/learn-vi-49-01-autocmd.html
]]
-- :h *nvim_create_autocmd()*
local function createCmd(...)
    return vim.api.nvim_create_autocmd(...);
end

local function createGroup(...)
    return vim.api.nvim_create_augroup(...);
end

local tidyAutoGroup = createGroup("tidyCode", { clear = true, });

-- source: https://riptutorial.com/vim/example/26597/delete-trailing-spaces-in-a-file
createCmd(
    { "BufWritePre" },
    {
        -- pattern = { "*.lua" };
        -- command = "%s/\\s\\+$//e", -- need more esacpe char
        command = [[%s/\s\+$//e]],
        group   = tidyAutoGroup,
    }
);

createCmd(
    "BufEnter",
    {
        pattern = "*",
        callback = function()
            vim.opt.formatoptions:remove("o") -- 確保新行不會繼承註解
        end,
    }
);
