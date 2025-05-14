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
local optionKeyMapping = require('keymap.optionKeyMapping');

function tool.getOptionKey(originalKey)
    if not IS_MAC or true then
        return ("<A-%s>"):format(originalKey);
    end
    local mappedKey = optionKeyMapping[originalKey];
    if not mappedKey then
        tool.echo(("Option Key Mapping Error: '%s' doesn't exit."):format(originalKey))
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

--[[
    Some references:
    https://vi.stackexchange.com/questions/744/can-i-pass-a-custom-string-to-the-gx-command
    https://github.com/neovim/neovim/blob/master/runtime/plugin/netrwPlugin.vim
--]]
local GITHUB_URL_TEMPLATE = "https://github.com/%s";

---@alias siteType string | "github"

---@param siteType? siteType
function tool.gotoRepo(siteType)
    local node = vim.treesitter.get_node();
    if not node then
        return;
    end

    local sr, sc = node:start();
    local er, ec = node:end_();

    local text = vim.api.nvim_buf_get_text(0, sr, sc ,er, ec, {})[1];
    if not text then
        return;
    end
    text = text:gsub("[\"']", ""); -- trim quote marks
    local REPO_PATTERN = [[[%w%-%.]+/[%w%-%.]+]];
    if not text:match(REPO_PATTERN) then
        print("No Git Repo Pattern for: " .. text);
        return;
    end

    local url;
    if not siteType or siteType == 'github' then
        url = GITHUB_URL_TEMPLATE:format(text);
    end
    vim.fn['netrw#BrowseX'](url, true);
end

-- https://neovim.io/doc/user/treesitter.html
function tool.extract()
    local current = vim.treesitter.get_node();
    local trace = {};

    local function findFuncDeclare(node)
        if node == nil then
            return;
        end
        table.insert(trace, { node:type(), node:range()});
        local parent = node:parent();
        if parent == nil then
            return;
        end
        -- local parentType = parent:type();
        -- if parentType == "function_declaration" or parent:type() == "function_definition" then
        --     -- found!!
        --     return parent;
        -- end
        return findFuncDeclare(parent);
    end

    findFuncDeclare(current);
    -- local funcScope = findFuncDeclare(current);
    -- tool.echo(funcScope:type());
    tool.echo(trace);
end

-- :help filename-modifiers
function tool.getBufferFileName()
    return vim.fn.expand('%:t');
end

return tool;
