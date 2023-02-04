local tool = {};

function tool.echo(object)
    return vim.api.nvim_echo({{ vim.inspect(object) }}, true, {});
end

local function printNode(node, name)
    if node == nil then
        tool.echo {
            name = name,
            type = "nil"
        };
        return;
    end
    local row, col = node:start();
    tool.echo {
        name = name,
        type = node:type(),
        pos  = { row, col },
    };
end

function tool.extract()
    local r, c = unpack(vim.api.nvim_win_get_cursor(0))
    r = r - 1;
    local current = vim.treesitter.get_node_at_pos(0, r, c);
    tool.echo();

    local function findFuncDeclare(node)
        if node == nil then
            return;
        end
        local parent = node:parent();
        if parent == nil then
            return;
        end
        local parentType = parent:type();
        if parentType == "function_declaration" or parent:type() == "function_definition" then
            -- found!!
            return parent;
        end
        return findFuncDeclare(parent);
    end

    local funcScope = findFuncDeclare(current);

    printNode(funcScope, "funcScope");
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
