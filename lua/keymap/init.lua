--[[ basic ]]
require("keymap.lazy");
--[[ lsp ]]
require('keymap.lsp').setupKeymap();

--[[
    TODO:
        1. write a function can subsittue every , into new line symbol
        2. write a function which can acquire node text e.ge inside the quote
--]]
local tool         = require("tools.tool");
local getOptionKey = tool.getOptionKey;
local cramp        = tool.cramp;
local cmd = vim.cmd;

--[[
    Mapping Function Abbreviation
    https://neovim.io/doc/user/api.html#nvim_set_keymap()
]]
-- IIFE
local modeMap = (function()
    local OPT_INDEX   = 3;
    local DEFAULT_OPT = { silent = true, remap = false };
    return function(mode, ...)
        local params = {...};
        params[OPT_INDEX] = vim.tbl_extend('keep', params[OPT_INDEX] or {}, DEFAULT_OPT);
        return vim.keymap.set(mode, unpack(params));
    end;
end)();
-- checkout :h map-table to see difference
local function map(...)   return modeMap('',         ...); end
local function nmap(...)  return modeMap('n',        ...); end
local function imap(...)  return modeMap('i',        ...); end
local function cmap(...)  return modeMap('c',        ...); end
local function vmap(...)  return modeMap('v',        ...); end
local function omap(...)  return modeMap('o',        ...); end
local function vomap(...) return modeMap({'v', 'o'}, ...); end

local function allmap(...)
    modeMap({'n', 'i', 'c', 'v', 'o', 't'}, ...);
end

--[[
    Global Function
]]
-- operator pending purpose
function GetConditionStatementSelectorScript()
    -- embedded match whole word
    local emww = function(w) return cramp(w, true); end

    if vim.bo.filetype == "lua" then
        -- 在使用ctrl-r= 的表達式時，\<Esc>似乎是不會跳出該表達示，所以關閉高亮得以被呼叫
        return 'execute "normal! ?' .. emww 'if' .. '\\rwv/' .. emww 'then' .. '\\rge\\<Esc>:noh\\rgv"';
    else
        return 'execute "normal! ?' .. emww 'if' .. '\\r:noh\\rwvi("';
    end
end

---@param str string
local function desc(str)
    return { desc = str };
end

---@param tab table
local function desc_opts(tab)
    local temp = tab[1];
    tab[1] = nil;
    return vim.tbl_deep_extend("force", { desc = temp }, tab);
end

-- All
map('<Space>', '<Nop>');
allmap(';a', '<Esc>', desc "Escape");

-- Normal Mode
nmap('zp',    '"0p',                                 desc "Paste From Yanked");
nmap('zh',    ':let @/ = ""<CR>',                    desc "Clear Search History");
nmap('zd',    ':%bd | e#<CR>',                       desc "Delete All Buffers But This One");
nmap('<C-N>', ':w | source %<CR>',                   desc "Save And Source");
nmap(';j',    '15j',                                 desc "Move Down 15 Lines");
nmap(';k',    '15k',                                 desc "Move Up 15 Lines");
nmap(';p',    'viw\"0p',                             desc "Pase On Current Word");
nmap(';f',    '/<C-R>+<CR>',                         desc "Search Copyed Word");
nmap(';r',    ('/%s<CR>'):format(cramp'<C-R>+'),     desc "Search Restricted Copyed Word");
nmap(';w',    ':%s/\\<<C-R><C-W>\\>//g<Left><Left>', desc "Subsitute Current Word In This Buffer");

nmap('<leader>a',  'ggVG',                             desc "Select All");
nmap('<leader>em', 'ciw<C-R>=<C-R>"',                  desc "Expression Math");
nmap('<leader>vt', ':vs<CR><C-W>l:ter<CR>i',           desc "Split [V]ertical [T]erminal");
nmap('<leader>gh', 'yiw<Cmd>Telescope help_tags<CR>p', desc "Get Help");
nmap('<leader>gp', tool.gotoRepo,                      desc "[G]o to Github Re[p]ository");

nmap(getOptionKey 's', ':w | source %<CR>',      desc "Save And Source");
nmap(getOptionKey 'd', ':silent ! open dict://<C-R><C-W><CR>', desc "Search Word On Dictionary");
-- https://apple.stackexchange.com/questions/90040/look-up-a-word-in-dictionary-app-in-terminal
--[[
    m' will push current cursor position to jump list
    nmap(getOptionKey 'o', "m':normal o<CR>0D<C-O>");
]]
nmap(getOptionKey 'o', ":call append(line('.'),   '')<CR>", desc "Just Open Line Below");
nmap(getOptionKey 'O', ":call append(line('.')-1, '')<CR>", desc "Just Open Line Above");
nmap(getOptionKey ',', "<C-W><",  desc "Decrease Window Width");
nmap(getOptionKey '.', "<C-W>>",  desc "Increase Window Width");
nmap(getOptionKey '<', "5<C-W><", desc "Decrease Window Width By 5");
nmap(getOptionKey '>', "5<C-W>>", desc "Increase Window Width By 5");

nmap('<leader>vd', function()
    cmd 'vs';
    vim.lsp.buf.definition();
end, desc "Split [V]ertical Lsp [D]efinition");
nmap('<leader>ss', function()
    local lineNumber = vim.fn.line('.');
    local rangeStr   = '\\%>' .. lineNumber - 1 .. 'l' .. '\\%<' .. lineNumber + 1 .. 'l';
    local patternStr = '\\s\\+';
    local operateStr = 'Ngnc <Esc>';
    local cleanupStr = ':let @/ = ""<CR>';
    local cmdStr     = '/' .. rangeStr .. patternStr .. "<CR>" .. operateStr .. cleanupStr;
    return cmdStr;
end, desc_opts{ "Shrink Spaces", expr = true });
-- IIFE
nmap('<leader>nl', (function()
    -- vim.opt.relativenumber is always a table
    local is_relative = false;
    return function()
        is_relative = not is_relative;
        vim.opt.relativenumber = is_relative;
    end
end)(), desc "Toggle Relative Line Number");

-- Insert Mode
imap(getOptionKey 'h', '<Left>',  desc "Move Cursor Left");
imap(getOptionKey 'j', '<Down>',  desc "Move Cursor Down");
imap(getOptionKey 'k', '<Up>',    desc "Move Cursor Up");
imap(getOptionKey 'l', '<Right>', desc "Move Cursor Right");
imap('<C-h>',          '<Left>',  desc "Move Cursor Left");
imap('<C-j>',          '<Down>',  desc "Move Cursor Down");
imap('<C-k>',          '<Up>',    desc "Move Cursor Up");
imap('<C-l>',          '<Right>', desc "Move Cursor Right");
imap(getOptionKey 'o', "<C-O>:call append(line('.'),   '')<CR>", desc "Open Line Below");
imap(getOptionKey 'O', "<C-O>:call append(line('.')-1, '')<CR>", desc "Open Line Above");

-- Visual Mode
--[[
    範圍搜尋
    ctrl-r= 可以貼上用expression取得的字串, See 'c_ctrl-r'
    參考 https://vim.fandom.com/wiki/Search_only_over_a_visual_range
]]
local visual_range = [[\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l]];
vmap('zp', '"0p', desc "Paste From Yanked"); -- paste from yanked
vmap('/', "<Esc>/" .. visual_range, desc "Search [/] In Visual Range");
vmap('?', "<Esc>?" .. visual_range, desc "Search [?] In Visual Range");
-- c_ctrl-r 會貼上指定的暫存器裡的東西
vmap('f',  'y/<C-R>"<CR>',                             desc "Search Selected String");
vmap(';f', 'y/' .. cramp [[<C-R>"]] .. '<CR>',         desc "Search Selected String Restrictedly");
vmap(';;', '<Esc>/' .. cramp [[<C-R><C-W>]] .. '<CR>', desc "Search Current Word");

local alignComment = function()
    local ft = require('Comment.ft');
    local U  = require('Comment.utils');
    local commentFormat = ft.get(vim.bo.filetype, U.ctype.linewise); -- `//%s`
    if not commentFormat then
        return;
    end
    local alignRegex = "\\s" .. commentFormat:gsub("%%s", "");
    local alignCmdFormat = ":EasyAlign -1/%s/<CR>gv";
    return alignCmdFormat:format(alignRegex);
end;
vmap('<leader>ac', alignComment, desc_opts{ "Align Comments", expr = true, silent = true });

-- Command Mode
cmap(';m', cramp '' .. '<Left><Left>');


--[[
    以下的keymap算是學習記錄，並不實用
--]]
-- Visual Operation common
vomap('cs', [[:<C-U><C-R>=v:lua.GetConditionStatementSelectorScript()<CR><CR>]]);
vomap('om', [[:<C-U>execute "normal! ?self\r:noh\rv3e"<CR>]]); -- object momber / method

--[[
    補充
    1. ctrl-u 的用途：https://vi.stackexchange.com/questions/9751/understanding-ctrl-u-combination
    其實就像在terminal輸入ctrl-u一樣，清空目前的內容
    2. 'normal!' https://learnvimscriptthehardway.stevelosh.com/chapters/29.html
    3. omap很難用：https://learnvimscriptthehardway.stevelosh.com/chapters/15.html
]]
-- examples
omap('in(', ':<C-U>normal! f(vi(<CR>'); -- range between () in same line
omap('F', ':<C-U>normal! 0f(hviw<CR>'); -- range word precede first () in same line
