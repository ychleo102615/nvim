local opt = vim.opt;

-- 剪貼簿共用
opt.clipboard = "unnamedplus";
opt.showcmd   = true;

-- 顯示設定
opt.number            = true;
opt.mouse             = "a";
opt.cursorline        = true;
opt.hlsearch          = true;
opt.ruler             = true;
-- opt.relativenumber = true;
-- opt.cmdheight      = 5;

-- 縮排
opt.expandtab   = true;
opt.ts          = 4;
opt.shiftwidth  = 4;
opt.smartindent = true;

-- fold
opt.foldmethod     = "indent";
opt.foldlevelstart = 99;

-- keymap
opt.timeoutlen = 300;

-- spell
opt.ignorecase = true;

opt.splitbelow = true; -- Put new windows below current
opt.splitright = true; -- Put new windows right of current
