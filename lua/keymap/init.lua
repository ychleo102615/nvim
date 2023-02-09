require("keymap.lazy");
-- nmap('<C-M>', ':w | source %<CR>');   -- It seems that  ctrl-m is equivalent to Return key
--[[
    TODO: write a function can subsittue every , into new line symbol
--]]
local tool         = require("tools.tool");
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
    -- local fileExt = vim.fn.expand('%:e');
    -- embedded match whole word
    local emww = function(w) return MatchWholeWord(w, true); end

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
nmap('zp',             '"0p',                    desc "Paste From Yanked");
nmap('zh',             ':let @/ = ""<CR>',       desc "Clear Search History");
nmap('zd',             ':%bd | e#<CR>',          desc "Delete All Buffers But This One");
nmap('<C-N>',          ':w | source %<CR>',      desc "Save And Source");
nmap(';j',             '15j',                    desc "Move Down 15 Lines");
nmap(';k',             '15k',                    desc "Move Up 15 Lines");
nmap(';p',             'viw\"0p',                desc "Pase On Current Word");
nmap('<leader>em',     'ciw<C-R>=<C-R>"',        desc "Expression Math");
nmap('<leader>vt',     ':vs<CR><C-W>l:ter<CR>i', desc "Split [V]ertical [T]erminal");
nmap(getOptionKey 's', ':w | source %<CR>',      desc "Save And Source");
-- https://apple.stackexchange.com/questions/90040/look-up-a-word-in-dictionary-app-in-terminal
nmap(getOptionKey 'd', ':silent ! open dict://<C-R><C-W><CR>', desc "Search Word On Dictionary");
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
nmap(';w', function()
    local prefix = "yiw:%s/\\<<C-R>0\\>/";
    return IS_USING_VSCODE and prefix or prefix .. "/g<Left><Left>";
end, desc_opts{ "Subsitute Current Word In This Buffer", expr = true });

-- vim.opt.relativenumber is always a table
-- IIFE
local toggle_relative_line_number = (function()
    local is_relative = false;
    return function()
        is_relative = not is_relative;
        vim.opt.relativenumber = is_relative;
    end
end)();
nmap('<leader>nn', toggle_relative_line_number, desc "Toggle Relative Line Number");
nmap('<leader>a', 'ggVG', desc "Select All");

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

--[[
    Plugin
]]
--[[ lsp ]]
require('keymap.lsp').setupKeymap();
--[[ TreeSitter Playground ]]
nmap('<Space>p', ':TSPlaygroundToggle<CR>');
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
vmap('<Space>ac', alignComment, { expr = true, silent = true, desc = "Align Comments" });
--[[ Telescope ]]
nmap('<Space>ff', '<Cmd>Telescope find_files<CR>');
nmap('<Space>fs', '<Cmd>Telescope live_grep<CR>');
nmap('<Space>fb', function()
    local builtin = require('telescope.builtin');
    local themes  = require('telescope.themes');
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
    local builtin = require('telescope.builtin');
    local themes  = require('telescope.themes');
    builtin.git_branches(themes.get_ivy {
        layout_config = {
            mirror = false,
            prompt_position = 'bottom',
        },
        initial_mode = 'normal',
    });
end);

