local function modeMap(mode, ...)
    local params = {...};
    params[3] = params[3] or {
        -- remap = false,
        silent = true,
    };
    return vim.keymap.set(mode, unpack(params));
    -- return vim.keymap.set(mode, ...);
end
local function nmap(...) return modeMap('n', ...); end
local function imap(...) return modeMap('i', ...); end
local function vmap(...) return modeMap('v', ...); end
local function cmap(...) return modeMap('c', ...); end
local function omap(...) return modeMap('o', ...); end

function matchWholeWord(word, isEmbeddedCode)
    -- 使用omap時，可能需要以字串形式描述指令，反斜線會被視為特殊符號
    if isEmbeddedCode then
        return [[\\<]] .. word .. [[\\>]];
    end
    return '\\<' .. word .. '\\>';
end

-- operator pending purpose
function _G.getConditionStatementScript()
    local fileExt = vim.fn.expand('%:e');
    if fileExt == "lua" then
        -- embedded match whole word
        local emww = function(w) return matchWholeWord(w, true); end
        return 'execute "normal! ?' .. emww'if' .. '\\rwv/' .. emww'then' .. '\\rge" ';
    else
        return 'normal! vi(';
    end
end

-- Normal Mode
nmap('zp', 'viw\"0p');
nmap('zhe', function()
    print("Hello, keymapping!");
end);
nmap('<Space>', '<Nop>');
nmap('<Space>j', '<C-F>');
nmap('<Space>k', '<C-B>');
nmap('<Space>w', '<C-W>');
-- vim.opt.relativenumber is always a table
local defaultShowRelativeNumber = false;
local function toggleRelativeLineNumber()
    defaultShowRelativeNumber = not defaultShowRelativeNumber;
    vim.opt.relativenumber = defaultShowRelativeNumber;
end
nmap('<Space>l', toggleRelativeLineNumber);
nmap('<Space>r', ':source $MYVIMRC<CR>');
nmap('zhh', ':noh<CR>');

-- Insert Mode
imap('<C-o>', '<Esc>o');
imap('<C-i>', '<Esc>O');
imap('jf', '<Esc>'); 

-- Visual Mode
--[[
    範圍搜尋
    ctrl-r= 可以貼上用expression取得的字串, See 'c_ctrl-r'
    參考 https://vim.fandom.com/wiki/Search_only_over_a_visual_range
]]
local scriptGetSelectionLineRage = [[\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l]];
vmap('/', "<Esc>/" .. scriptGetSelectionLineRage);
vmap('?', "<Esc>?" .. scriptGetSelectionLineRage);
vmap('f', 'y/<C-R>"<CR>');
vmap('jf', '<Esc>'); 
vmap('cs', [[:<C-U><C-R>=v:lua.getConditionStatementScript()<CR><CR>]]);

-- Command Mode
cmap('mww', matchWholeWord'' .. '<Left><Left>');
cmap('hh', 'noh<CR>');

-- Operation Mode
omap('cs', [[:<C-U><C-R>=v:lua.getConditionStatementScript()<CR><CR>]]);  -- condition statement
--[[
    補充
    ctrl-u 的用途：https://vi.stackexchange.com/questions/9751/understanding-ctrl-u-combination
    omap很難用：https://learnvimscriptthehardway.stevelosh.com/chapters/15.html
]]
-- examples
omap('in(', ':<C-U>normal! f(vi(<CR>');   -- range between () in same line
omap('F', ':<C-U>normal! 0f(hviw<CR>');   -- range word precede first () in same line


print("keymap設定完成");
