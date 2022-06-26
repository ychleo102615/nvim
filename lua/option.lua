local opt = vim.opt;

-- 剪貼簿共用
opt.clipboard = "unnamedplus";
opt.showcmd = true;

-- 顯示設定
opt.number = true;
opt.cmdheight = 5;
opt.mouse = "a";
opt.cursorline = true;
opt.hlsearch = true;
-- opt.relativenumber = true;

-- tab轉空格
opt.expandtab = true;
opt.ts = 4;
opt.shiftwidth = 4;

opt.smartindent = true;
