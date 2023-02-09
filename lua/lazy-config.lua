local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- https://github.com/folke/lazy.nvim#%EF%B8%8F-importing-specs-config--opts
require("lazy").setup({
    { import = "plugins" },
    { import = "plugins.editor" },
});
-- require("lazy").setup("plugins");

-- Events: :h autocmd-events
