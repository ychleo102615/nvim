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

function tool.cramp(word, isEmbeddedCode)
    -- 使用omap時，可能需要以字串形式描述指令，反斜線會被視為特殊符號
    if isEmbeddedCode then
        -- :help expr-quote
        return [[\\<]] .. word .. [[\\>]];
    end
    return '\\<' .. word .. '\\>';
end

function tool.query()
    local r, c = unpack(vim.api.nvim_win_get_cursor(0))
    ---@diagnostic disable-next-line: missing-parameter
    local node = vim.treesitter.get_node_at_pos(0, r-1, c);

    -- tool.echo(node:named());
    local sr, sc = node:start();
    local er, ec = node:end_();

    -- local lines = vim.api.nvim_buf_get_text(0, sr, sc ,er, ec, {});
    -- if #lines == 0 then
    --     return;
    -- end

    local text = vim.api.nvim_buf_get_text(0, sr, sc ,er, ec, {})[1];
    if not text then
        return;
    end
    print(text);
    -- tool.echo{ text, text:match([[%w+/%w+]]) };
    tool.echo{ text, text:match([[ ["']%w+/%w+["'] ]]) };

    local GIT_HUB = "https://github.com/%s";
end
return tool;
