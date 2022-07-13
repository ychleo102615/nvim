local function modeMap(mode, ...)
    local params = { ... };
    params[3] = params[3] or {
        -- remap = false,
        silent = true,
    };
    return vim.keymap.set(mode, unpack(params));
    -- return vim.keymap.set(mode, ...);
end
local function map(...) return modeMap('', ...); end
local function nmap(...) return modeMap('n', ...); end
local function imap(...) return modeMap('i', ...); end
local function cmap(...) return modeMap('c', ...); end
local function vmap(...) return modeMap('v', ...); end
local function omap(...) return modeMap('o', ...); end

function MatchWholeWord(word, isEmbeddedCode)
    -- 使用omap時，可能需要以字串形式描述指令，反斜線會被視為特殊符號
    if isEmbeddedCode then
        return [[\\<]] .. word .. [[\\>]];
    end
    return '\\<' .. word .. '\\>';
end

-- operator pending purpose
function GetConditionStatementSelectorScript()
    local fileExt = vim.fn.expand('%:e');
    -- embedded match whole word
    local emww = function(w) return MatchWholeWord(w, true); end

    if fileExt == "lua" then
        -- 在使用ctrl-r= 的表達式時，\<Esc>似乎是不會跳出該表達示，所以關閉高亮得以被呼叫
        return 'execute "normal! ?' .. emww 'if' .. '\\rwv/' .. emww 'then' .. '\\rge\\<Esc>:noh\\rgv"';
    else
        return 'execute "normal! ?' .. emww 'if' .. '\\r:noh\\rwvi("';
    end
end

local GetOptionKey = (function()
    local OPT_KEY = {
        -- direction
        h = "˙",
        j = "∆",
        k = "˚",
        l = "¬",
    };
    return function(originalKey)
        local mappedKey = OPT_KEY[originalKey]
        assert(mappedKey ~= nil, ("Option Key Mapping Error:'%s'"):format(originalKey));
        return mappedKey;
    end
end)();

-- All
map('<Space>', '<Nop>');

-- Normal Mode
nmap('zp', '"0p'); -- paste from yanked
nmap('zh', ':let @/ = ""<CR>'); -- clear search history
-- nmap('zh', ':noh<CR>');
nmap('<Space>j', '<C-F>M');
nmap('<Space>k', '<C-B>M');
-- nmap('<Space>w', '<C-W>');
nmap('<C-S>', ':w<CR>');
nmap('<C-Q>', ':qa<CR>');
nmap(';j', '15j');
nmap(';k', '15k');
nmap(';p', 'viw\"0p');
nmap(GetOptionKey 'j', ':m+<CR>==');
nmap(GetOptionKey 'k', ':m-2<CR>==');

local ReplaceFileWords = function()
    local prefix = "yiw:%s/\\<<C-R>0\\>/";
    if vim.fn.exists 'g:vscode' ~= 0 then return prefix; end
    return prefix .. "/g<Left><Left>";
end
nmap(';w', ReplaceFileWords, { expr = true });
local ToggleRelativeLineNum = function()
    local defaultShowRelativeNumber = false;
    return function()
        defaultShowRelativeNumber = not defaultShowRelativeNumber;
        -- vim.opt.relativenumber is always a table
        vim.opt.relativenumber = defaultShowRelativeNumber;
    end
end
nmap('<Space>n', ToggleRelativeLineNum());
--[[
    plugin key map
]]
nmap('<Space>h', ':BufferLineCyclePrev<CR>');
nmap('<Space>l', ':BufferLineCycleNext<CR>');
nmap('<Space>o', ':BufferLinePick<CR>');
nmap('<Space>cp', ':BufferLinePickClose<CR>');
nmap('<Space>cl', ':BufferLineCloseLeft<CR>');
nmap('<Space>cr', ':BufferLineCloseRight<CR>');
nmap('<Space>cg', ':BufferLineGroupClose ungrouped<CR>');
nmap('<Space>d', ':NvimTreeToggle<CR>');
nmap('<Space>r', ':NvimTreeFindFile<CR>');
-- lsp
nmap('<Space>e', vim.diagnostic.open_float)
nmap('[d', vim.diagnostic.goto_prev);
nmap(']d', vim.diagnostic.goto_next);
nmap('<Space>q', vim.diagnostic.setloclist);
nmap('<Space>f', '<Cmd>Telescope find_files<CR>');
nmap('<Space>s', '<Cmd>Telescope live_grep<CR>');
nmap('<Space>t', '<Cmd>Telescope <Tab>');

-- Insert Mode
imap(';a', '<Esc>');
imap(GetOptionKey 'h', '<Left>');    -- option h
imap(GetOptionKey 'j', '<Down>');    -- option j
imap(GetOptionKey 'k', '<Up>');      -- option k
imap(GetOptionKey 'l', '<Right>');   -- option l

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
vmap('is', [[:<C-U><C-R>=v:lua.GetConditionStatementSelectorScript()<CR><CR>]]);
vmap(';;', 'iwy/' .. MatchWholeWord [[<C-R>"]] .. '<CR>');
vmap(GetOptionKey 'j', ":m '>+1<CR>gv=gv");    -- option j
vmap(GetOptionKey 'k', ":m '<-2<CR>gv=gv");    -- option k

-- Command Mode
cmap(';m', MatchWholeWord '' .. '<Left><Left>');

-- Operation Mode
omap('is', [[:<C-U><C-R>=v:lua.GetConditionStatementSelectorScript()<CR><CR>]]); -- condition statement
local function getOp()
    local emww = function(w) return MatchWholeWord(w, true); end
    return ':<C-U>execute "normal! ?' .. emww 'if' .. '\\rvw/' .. emww 'then' .. '\\rge" <CR>';
    --return ':<C-U>execute "normal! ?' .. emww'if' .. '\\rvw/' .. emww'then' .. '\\rge^[:noh\\rgv" <CR> ';
    --return ':<C-U>' .. GetConditionStatementSelectorScript() .. '<CR>';
end

omap('ics', getOp, { expr = true });
--[[
    補充
    ctrl-u 的用途：https://vi.stackexchange.com/questions/9751/understanding-ctrl-u-combination
    omap很難用：https://learnvimscriptthehardway.stevelosh.com/chapters/15.html
]]
-- examples
omap('in(', ':<C-U>normal! f(vi(<CR>'); -- range between () in same line
omap('F', ':<C-U>normal! 0f(hviw<CR>'); -- range word precede first () in same line
