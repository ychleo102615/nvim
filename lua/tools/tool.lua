local tool = {};

function tool.echo(object)
    return vim.api.nvim_echo({{ vim.inspect(object) }}, true, {});
end

local cmd = vim.cmd;
--[[
    各種輸入ex command的方式
    nmap('<Space>i', '<Cmd>ToggleAlternate<CR>');
    vim.cmd(cmdStr)
    vim.api.nvim_command(cmdStr)
--]]
function tool.wrapCmd(cmdStr)
    return function() return cmd(cmdStr) end;
end

function tool.getOptionKey(originalKey)
    local mappedKey = require('keymap.optionKeyMapping')[originalKey];
    if not mappedKey then
        tool.echo(("Option Key Mapping Error:'%s'"):format(originalKey))
    end
    return mappedKey;
end

return tool;
