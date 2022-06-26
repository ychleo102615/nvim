local function modeMap(mode, ...)
    -- local params = {...};
    -- params[3] = params[3] or {
    --     remap = false,
    -- };
    -- return vim.keymap.set(mode, unpack(params));
    return vim.keymap.set(mode, ...);
end
local function nmap(...) return modeMap('n', ...); end
local function imap(...) return modeMap('i', ...); end
local function vmap(...) return modeMap('v', ...); end
local function cmap(...) return modeMap('c', ...); end
local function omap(...) return modeMap('o', ...); end

function matchWholeWord(word, isEmbeddedCode)
    if type(isEmbeddedCode) == nil then isEmbeddedCode = false; end
    if isEmbeddedCode then
        return [[\\<]] .. word .. [[\\>]];
    end
    return '\\<' .. word .. '\\>';
end

function InIfCon()
    local emww = function(w) return matchWholeWord(w, true); end
    return 'normal! ?' .. emww('if', true) .. [[\r:nohlsearch\rwv/]] .. emww('then') .. [[\rge]];
    --return 'normal! ?' .. emww('if', true) .. [[\rwv/]] .. emww('then') .. [[\rge]];
end

function _G.getSuffixOfIfStatement()
    local fileExt = vim.fn.expand('%:e');
    if fileExt == "lua" then
        --return '?' .. matchWholeWord('if') .. '<CR>wv/' .. matchWholeWord('then') .. '<CR>ge';
        return ':<C-U>execute "' .. InIfCon() .. '" <CR>';
    else
        return 'i(';
    end
end

function _G.testIf()
    local fileExt = vim.fn.expand('%:e');
    print("intestif");
    if fileExt == "lua" then
        return 'execute "' .. InIfCon() .. '"';
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
nmap('zhh', ':noh<CR>', {silent = true}); -- hide highlight

-- Insert Mode
imap('<C-p>', '打中文啊');
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
vmap('z/', "<Esc>/" .. scriptGetSelectionLineRage);
vmap('z?', "<Esc>?" .. scriptGetSelectionLineRage);
vmap('f', 'y/<C-R>"<CR>');
vmap('jf', '<Esc>'); 
vmap('iif', '<Esc>' .. getSuffixOfIfStatement'i');
vmap('iiif', InIfCon());
vmap('cs', InIfCon());

-- Command Mode
cmap('mww', matchWholeWord'' .. '<Left><Left>');
cmap('hh', 'noh<CR>');

-- Operation Mode （遇到lua script不管用的情況, 使用vim.cmd補救）
--vim.cmd(' onoremap cs ' .. getSuffixOfIfStatement());
--vim.cmd(' onoremap iif :<C-U>execute "' .. InIfCon() .. '" <CR>');
--vim.cmd([[ onoremap iif :<C-U>execute "normal! ?\\<if\\>\rwv/\\<then\\>\rge" <CR> ]]);
--vim.cmd([[ onoremap iif :<C-U>execute "normal! ?if\rwv/then\rge" <CR> ]]);  -- stable version
--omap('cs', getSuffixOfIfStatement());
omap('cs', [[:<C-U><C-R>=v:lua.testIf()<CR><CR>]]);
--omap('cs', [[:<C-U><C-R>=v:lua.testIf()<CR>]]);
omap('cx', 'i(');

-- omap 範例
vim.cmd [[ onoremap ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr> ]];
vim.cmd [[ onoremap in( :<c-u>normal! f(vi(<cr> ]];
--[[
    omap('F', '0f(hviw');
    vim.api.nvim_set_keymap('o', 'F', '0f(hviw', {});
    補充
    ctrl-u 的用途：https://vi.stackexchange.com/questions/9751/understanding-ctrl-u-combination
]]
vim.cmd [[ onoremap <silent> F :<C-U>normal! 0f(hviw<CR> ]]


print("keymap設定完成");
