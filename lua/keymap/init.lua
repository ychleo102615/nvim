require("keymap.lazy");
--[[
    TODO: write a function can subsittue every , into new line symbol
--]]
local tool         = require("tools.tool");
local wrapCmd      = tool.wrapCmd;
local getOptionKey = tool.getOptionKey;

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
local function xmap(...)  return modeMap('x',        ...); end

local function allmap(...)
    map(...);
    imap(...);
    cmap(...);
end

--[[
    Global Function
]]
function MatchWholeWord(word, isEmbeddedCode)
    -- 使用omap時，可能需要以字串形式描述指令，反斜線會被視為特殊符號
    if isEmbeddedCode then
        -- :help expr-quote
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

-- All
map('<Space>', '<Nop>');
allmap(';a', '<Esc>');

-- Normal Mode
nmap('zp', '"0p'); -- paste from yanked
nmap('zh', ':let @/ = ""<CR>'); -- clear search historykeyini
nmap('zd', ':%bd | e#<CR>');
nmap('ga', '<Plug>(EasyAlign)');
-- nmap('zh', ':noh<CR>');
nmap('<Space>vt', ':vs<CR><C-W>l:ter<CR>i');
-- 'gd' refer to my lsp keymap
-- nmap('<Space>vd', ':vs<CR><C-W>lgd', { remap = true });
nmap('<Space>vd', function()
    local lastWin = vim.api.nvim_get_current_win();
    cmd 'vs';
    vim.api.nvim_set_current_win(lastWin);
    vim.lsp.buf.definition();
end);
nmap('<Space>m',  'ciw<C-R>=<C-R>"');
nmap('<Space>s', function()
    local lineNumber = vim.fn.line('.');
    local rangeStr   = '\\%>' .. lineNumber - 1 .. 'l' .. '\\%<' .. lineNumber + 1 .. 'l';
    local patternStr = '\\s\\+';
    local operateStr = 'Ngnc <Esc>';
    local cleanupStr = ':let @/ = ""<CR>';
    local cmdStr     = '/' .. rangeStr .. patternStr .. "<CR>" .. operateStr .. cleanupStr;
    return cmdStr;
end, { expr = true, silent = true });   -- shrink spaces
nmap('<C-N>', ':w | source %<CR>');
-- nmap('<C-M>', ':w | source %<CR>');   -- It seems that  ctrl-m is equivalent to Return key
nmap(';j', '15j');
nmap(';k', '15k');
nmap(';p', 'viw\"0p');
nmap(getOptionKey 's', ':w | source %<CR>');
-- https://apple.stackexchange.com/questions/90040/look-up-a-word-in-dictionary-app-in-terminal
nmap(getOptionKey 'd', ':silent ! open dict://<C-R><C-W><CR>');
--[[
    m' will push current cursor position to jump list
    nmap(getOptionKey 'o', "m':normal o<CR>0D<C-O>");
]]
nmap(getOptionKey 'o', ":call append(line('.'), '')<CR>");
nmap(getOptionKey 'O', ":call append(line('.')-1, '')<CR>");
nmap(getOptionKey ',', "<C-W><");
nmap(getOptionKey '.', "<C-W>>");
nmap(getOptionKey '<', "5<C-W><");
nmap(getOptionKey '>', "5<C-W>>");

local function ReplaceFileWords()
    local prefix = "yiw:%s/\\<<C-R>0\\>/";
    return IS_USING_VSCODE and prefix or prefix .. "/g<Left><Left>";
end
nmap(';w', ReplaceFileWords, { expr = true });

-- vim.opt.relativenumber is always a table
-- IIFE
local ToggleRelativeLineNum = (function()
    local defaultShowRelativeNumber = false;
    return function()
        defaultShowRelativeNumber = not defaultShowRelativeNumber;
        vim.opt.relativenumber = defaultShowRelativeNumber;
    end
end)();
nmap('<Space>nn', ToggleRelativeLineNum);

-- Insert Mode
imap(getOptionKey 'h', '<Left>');    -- option h
imap(getOptionKey 'j', '<Down>');    -- option j
imap(getOptionKey 'k', '<Up>');      -- option k
imap(getOptionKey 'l', '<Right>');   -- option l
imap(getOptionKey 'o', "<C-O>:call append(line('.'), '')<CR>");
imap(getOptionKey 'O', "<C-O>:call append(line('.')-1, '')<CR>");


-- Visual Mode
--[[
    範圍搜尋
    ctrl-r= 可以貼上用expression取得的字串, See 'c_ctrl-r'
    參考 https://vim.fandom.com/wiki/Search_only_over_a_visual_range
]]
local scriptGetSelectionLineRage = [[\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l]];
vmap('zp', '"0p'); -- paste from yanked
vmap('/', "<Esc>/" .. scriptGetSelectionLineRage);
vmap('?', "<Esc>?" .. scriptGetSelectionLineRage);
-- c_ctrl-r 會貼上指定的暫存器裡的東西
vmap('f', 'y/<C-R>"<CR>');
vmap('<Space>e', '<Esc>');
-- vmap(';;', 'iwy/' .. MatchWholeWord [[<C-R>"]] .. '<CR>');
vmap(';;', '<Esc>/' .. MatchWholeWord [[<C-R><C-W>]] .. '<CR>');
vmap(';w', '<Esc>/' .. MatchWholeWord [[<C-R><C-W>]] .. '<CR>');
vmap(';v', 'y/' .. MatchWholeWord [[<C-R>"]] .. '<CR>');
-- nmap(getOptionKey 'm', 'c<C-R>=<C-R>"');

-- Command Mode
cmap(';m', MatchWholeWord '' .. '<Left><Left>');

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

-- Visual Mode With out Select Mode
xmap('ga', '<Plug>(EasyAlign)');

--[[
    Plugin
]]
--[[ lsp ]]
require('keymap.lsp').setupKeymap();
--[[ TreeSitter Playground ]]
nmap('<Space>p', ':TSPlaygroundToggle<CR>');
--[[ Symbols Outline ]]
nmap('<Space>o', ':SymbolsOutline<CR>');
nmap('<Space>a', 'ggVG', { desc = "Select All" });
--[[ EasyAlign ]]
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
vmap('<Space>ac', alignComment, {expr = true, silent = true});
-- --[[ Toggler ]]
-- nmap('<Space>i', wrapCmd 'ToggleAlternate');
--[[ Telescope ]]
local builtin = require('telescope.builtin');
local themes  = require('telescope.themes');
nmap('<Space>ff', '<Cmd>Telescope find_files<CR>');
nmap('<Space>fs', '<Cmd>Telescope live_grep<CR>');
nmap('<Space>fb', function()
    -- builtin.current_buffer_fuzzy_find(themes.get_ivy {
    builtin.buffers(themes.get_ivy {
        --sorting_strategy = "descending";
        layout_config = {
            --height          = 0.9,
            prompt_position = 'bottom',
        },
        initial_mode = 'normal',
    });
end);
nmap('<leader>fh', '<Cmd>Telescope help_tags<Cr>');
nmap('<leader>fn', '<Cmd>Telescope current_buffer_fuzzy_find<Cr>');
nmap('<Space>gs', '<Cmd>Telescope git_status initial_mode=normal<CR>');

nmap('<Space>gc', '<Cmd>Telescope git_commits initial_mode=normal<CR>');
-- p means 'page', instead of using b which is occupid by 'buffer'
nmap('<Space>gp', '<Cmd>Telescope git_bcommits initial_mode=normal<CR>');
nmap('<Space>gb', function()
    builtin.git_branches(themes.get_ivy {
        layout_config = {
            mirror = false,
            prompt_position = 'bottom',
        },
        initial_mode = 'normal',
    });
end);

local TELESCOPE_DEBUG = false;
if TELESCOPE_DEBUG then
    local config = themes.get_dropdown {
    -- local config = {
        -- previewer = false,
        layout_config = {
        --    height          = 0.9,
            prompt_position = 'top',
        },
        sorting_strategy = 'ascending',
    };
    cmd 'messages clear';
    --print(vim.inspect(config));
    nmap('<Space>gc', function()
        builtin.git_commits(config);
        print(vim.inspect(config));
    end);
end
