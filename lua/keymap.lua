local function modeMap(mode, ...)
    local params = {...};
    params[3] = params[3] or {
        -- remap = false,
        silent = true,
    };
    return vim.keymap.set(mode, unpack(params));
    -- return vim.keymap.set(mode, ...);
end
local function map(...)  return modeMap('', ...);  end
local function nmap(...) return modeMap('n', ...); end
local function imap(...) return modeMap('i', ...); end
local function cmap(...) return modeMap('c', ...); end
local function vmap(...) return modeMap('v', ...); end
local function omap(...) return modeMap('o', ...); end

function matchWholeWord(word, isEmbeddedCode)
    -- 使用omap時，可能需要以字串形式描述指令，反斜線會被視為特殊符號
    if isEmbeddedCode then
        return [[\\<]] .. word .. [[\\>]];
    end
    return '\\<' .. word .. '\\>';
end

-- operator pending purpose
function getConditionStatementSelectorScript()
    local fileExt = vim.fn.expand('%:e');
    -- embedded match whole word
    local emww = function(w) return matchWholeWord(w, true); end

    if fileExt == "lua" then
        -- 在使用ctrl-r= 的表達式時，\<Esc>似乎是不會跳出該表達示，所以關閉高亮得以被呼叫
        return 'execute "normal! ?' .. emww'if' .. '\\rwv/' .. emww'then' .. '\\rge\\<Esc>:noh\\rgv"';
    else
        return 'execute "normal! ?' .. emww'if' .. '\\r:noh\\rwvi("';
    end
end

-- All
map('<Space>', '<Nop>');

-- Normal Mode
nmap('zp', 'viw\"0p');
nmap('zh', ':let @/ = ""<CR>'); -- clear search history
-- nmap('zh', ':noh<CR>');

nmap('<Space>j', '<C-F>M');
nmap('<Space>k', '<C-B>M');
nmap('<Space>w', '<C-W>');
-- vim.opt.relativenumber is always a table
nmap('<Space>l', (function()
    local defaultShowRelativeNumber = false;
    return function()
        defaultShowRelativeNumber = not defaultShowRelativeNumber;
        vim.opt.relativenumber = defaultShowRelativeNumber;
    end
end)());
-- nmap('<Space>r', ':source $MYVIMRC<CR>'); -- Not Working
nmap('<Space>d', ':NvimTreeToggle<CR>');
nmap('<C-J>', 'ddp');
nmap('<C-K>', 'ddkP');
nmap(';j', '10j');
nmap(';k', '10k');

-- Insert Mode
imap(';a', '<Esc>'); 
-- imap('(', '()<Esc>i');
-- imap('[', '[]<Esc>i');
-- imap('{', '{}<Esc>i');
-- imap([[']], [[''<Esc>i]]);
-- imap([["]], [[""<Esc>i]]);

-- Visual Mode
--[[
    範圍搜尋
    ctrl-r= 可以貼上用expression取得的字串, See 'c_ctrl-r'
    參考 https://vim.fandom.com/wiki/Search_only_over_a_visual_range
]]
local scriptGetSelectionLineRage = [[\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l]];
vmap('/', "<Esc>/" .. scriptGetSelectionLineRage);
vmap('?', "<Esc>?" .. scriptGetSelectionLineRage);
-- c_ctrl-r 會貼上指定的暫存器裡的東西
vmap('f', 'y/<C-R>"<CR>');
vmap(';a', '<Esc>'); 
vmap('<Space>e', '<Esc>');
vmap('is', [[:<C-U><C-R>=v:lua.getConditionStatementSelectorScript()<CR><CR>]]);
vmap(';;', 'iwy/<C-R>"<CR>');

-- Command Mode
cmap(';m', matchWholeWord'' .. '<Left><Left>');

-- Operation Mode
omap('is', [[:<C-U><C-R>=v:lua.getConditionStatementSelectorScript()<CR><CR>]]);  -- condition statement
local function getOp()
    local emww = function(w) return matchWholeWord(w, true); end
    return ':<C-U>execute "normal! ?' .. emww'if' .. '\\rvw/' .. emww'then' .. '\\rge" <CR>';
    --return ':<C-U>execute "normal! ?' .. emww'if' .. '\\rvw/' .. emww'then' .. '\\rge^[:noh\\rgv" <CR> ';
    --return ':<C-U>' .. getConditionStatementSelectorScript() .. '<CR>';
end
omap('ics', getOp, {expr = true});
--[[
    補充
    ctrl-u 的用途：https://vi.stackexchange.com/questions/9751/understanding-ctrl-u-combination
    omap很難用：https://learnvimscriptthehardway.stevelosh.com/chapters/15.html
]]
-- examples
omap('in(', ':<C-U>normal! f(vi(<CR>');   -- range between () in same line
omap('F', ':<C-U>normal! 0f(hviw<CR>');   -- range word precede first () in same line


