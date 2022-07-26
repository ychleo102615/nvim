--[[
    http://yyq123.github.io/learn-vim/learn-vi-49-01-autocmd.html
]]

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

