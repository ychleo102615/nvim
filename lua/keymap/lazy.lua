-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local getOptionKey = require("tools.tool").getOptionKey;

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
map("n", getOptionKey "j", ":m .+1<cr>==",     { desc = "Move down", silent = true })
map("n", getOptionKey "k", ":m .-2<cr>==",     { desc = "Move up",   silent = true })
map("v", getOptionKey "j", ":m '>+1<cr>gv=gv", { desc = "Move down", silent = true })
map("v", getOptionKey "k", ":m '<-2<cr>gv=gv", { desc = "Move up",   silent = true })
-- map("i", getOptionKey "j", "<Esc>:m .+1<cr>==gi", { desc = "Move down" })
-- map("i", getOptionKey "k", "<Esc>:m .-2<cr>==gi", { desc = "Move up" })

-- Copy Lines
map("n", getOptionKey "J", ":t.<cr>",      { desc = "Copy down", silent = true })
map("n", getOptionKey "K", ":t.-1<cr>",    { desc = "Copy up",   silent = true })
map("v", getOptionKey 'J', ":t'><CR>gv",   { desc = "Copy down", silent = true })
map("v", getOptionKey 'K', ":t'<-1<CR>gv", { desc = "Copy up",   silent = true })

-- buffers
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>",     { desc = "Next buffer" })

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
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
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
map("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open Quickfix List" })

-- quit
map("n", "<leader>qq", "<cmd>q<cr>",  { desc = "Quit" })
map("n", "<C-q>",      "<cmd>qa<cr>", { desc = "Quit all" })

-- floating terminal
map("n", "<leader>ft", function() require("lazy.util").float_term() end, { desc = "Terminal" })
map("t", "<esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

map("t", "<C-h>", "<c-\\><c-n><C-w>h", { desc = "Go to left window" })
map("t", "<C-j>", "<c-\\><c-n><C-w>j", { desc = "Go to lower window" })
map("t", "<C-k>", "<c-\\><c-n><C-w>k", { desc = "Go to upper window" })
map("t", "<C-l>", "<c-\\><c-n><C-w>l", { desc = "Go to right window" })

-- tabs
map("n", "<leader><tab>l",     "<cmd>tablast<cr>",     { desc = "Last Tab" })
map("n", "<leader><tab>f",     "<cmd>tabfirst<cr>",    { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>",      { desc = "New Tab" })
map("n", "<leader><tab>d",     "<cmd>tabclose<cr>",    { desc = "Close Tab" })
map("n", "<leader><tab>]",     "<cmd>tabnext<cr>",     { desc = "Next Tab" })
map("n", "<leader><tab>[",     "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "]t",                 "<cmd>tabnext<cr>",     { desc = "Next Tab" })
map("n", "[t",                 "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
