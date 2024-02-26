-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local optKey = require("tools.tool").getOptionKey;

local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    ---@cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({ lhs, mode = mode }).id] then
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys
map("n", "<Up>",    "<cmd>resize +1<cr>",          { desc = "Increase window height" })
map("n", "<Down>",  "<cmd>resize -1<cr>",          { desc = "Decrease window height" })
map("n", "<Left>",  "<cmd>vertical resize -1<cr>", { desc = "Decrease window width" })
map("n", "<Right>", "<cmd>vertical resize +1<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", optKey "j", ":m .+1<cr>==",     { desc = "Move down", silent = true })
map("n", optKey "k", ":m .-2<cr>==",     { desc = "Move up",   silent = true })
map("v", optKey "j", ":m '>+1<cr>gv=gv", { desc = "Move down", silent = true })
map("v", optKey "k", ":m '<-2<cr>gv=gv", { desc = "Move up",   silent = true })
-- map("i", getOptionKey "j", "<Esc>:m .+1<cr>==gi", { desc = "Move down" })
-- map("i", getOptionKey "k", "<Esc>:m .-2<cr>==gi", { desc = "Move up" })

-- Copy Lines
map("n", optKey "J", ":t.<cr>",      { desc = "Copy down", silent = true })
map("n", optKey "K", ":t.-1<cr>",    { desc = "Copy up",   silent = true })
map("v", optKey 'J', ":t'><CR>gv",   { desc = "Copy down", silent = true })
map("v", optKey 'K', ":t'<-1<CR>gv", { desc = "Copy up",   silent = true })

-- buffers
map("n", "[b",        "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b",        "<cmd>bnext<cr>",     { desc = "Next buffer" })
map("n", "<leader>b", "<cmd>b#<cr>",        { desc = "Last Buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
    "n",
    "<leader>ur",
    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / clear hlsearch / diff update" }
)

map("n", "gw", "*N")
map("x", "gw", "*N")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", (vim.v.searchforward and "n" or "N") .. "zz", { desc = "Next search result" })
map("x", "n", (vim.v.searchforward and "n" or "N") .. "zz", { desc = "Next search result" })
map("n", "N", (vim.v.searchforward and "N" or "n") .. "zz", { desc = "Prev search result" })
map("x", "N", (vim.v.searchforward and "N" or "n") .. "zz", { desc = "Prev search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>ll", "<cmd>:Lazy<cr>", { desc = "Lazy" })

map("n", "<leader>sl", "<cmd>lopen<cr>",  { desc = "Show Location List" })
map("n", "<leader>sq", "<cmd>copen<cr>",  { desc = "Show Quickfix List" })
map("n", "<leader>hl", "<cmd>lclose<cr>", { desc = "Hide Location List" })
map("n", "<leader>hq", "<cmd>cclose<cr>", { desc = "Hide Quickfix List" })
map("n", "[q",         vim.cmd.cprev,     { desc = "Previous quickfix" })
map("n", "]q",         vim.cmd.cnext,     { desc = "Next quickfix" })

-- quit
map("n", "<C-q>",          "<cmd>q<cr>",    { desc = "Quit" })
map("n", "<C-S-q>",        "<cmd>qa<cr>",   { desc = "Quit all" })
map("n", optKey "q", "<cmd>tabc<cr>", { desc = "Quit Tab" })
map("n", optKey "T", "<cmd>vs#<cr>",  { desc = "Restore Last Window in Vertical" })

-- floating terminal
-- map("n", "<leader>ft", function() require("lazy.util").float_term() end, { desc = "Terminal" })
map("t", "<esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

map("t", "<C-h>", "<c-\\><c-n><C-w>h", { desc = "Go to left window" })
map("t", "<C-j>", "<c-\\><c-n><C-w>j", { desc = "Go to lower window" })
map("t", "<C-k>", "<c-\\><c-n><C-w>k", { desc = "Go to upper window" })
map("t", "<C-l>", "<c-\\><c-n><C-w>l", { desc = "Go to right window" })

-- tabs
map("n", "<leader>tn", "<cmd>tabnew<cr>",      { desc = "New Tab" })
map("n", "<leader>tc", "<cmd>tabclose<cr>",    { desc = "Close Tab" })
map("n", "]t",         "<cmd>tabnext<cr>",     { desc = "Next Tab" })
map("n", "[t",         "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<C-S-l>",    "<cmd>tabnext<cr>",     { desc = "Next Tab" })
map("n", "<C-S-h>",    "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", optKey "l",   "<cmd>tabnext<cr>",     { desc = "Next Tab" })
map("n", optKey "h",   "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", optKey "E",   "<cmd>tabnext<cr>",     { desc = "Next Tab" })
map("n", optKey "W",   "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

map("n", optKey "L", "<cmd>+tabm<cr>", { desc = "Move Tab Next" })
map("n", optKey "H", "<cmd>-tabm<cr>", { desc = "Move Tab Previous" })

-- Moving between windows (from Ben Frain's talk at NeovimConf 2022)
for i = 1, 9 do
    map("n", "<leader>" .. i, ("<cmd>tabnext %d<cr>"):format(i), { desc = "Move To Tab " .. i });
end

map("n", "<leader>lg", function()
    local float = require("lazy.util").float_term({"lazygit"});
    vim.keymap.set("t", "<esc>", "<esc>", { buffer = float.buf, nowait = true });
end, { desc = "Lazygit" });
