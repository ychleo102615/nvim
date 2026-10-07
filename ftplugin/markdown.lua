-- markview.nvim only fully renders tables (borders/pipes joined) when
-- 'wrap' is off; with wrap on it deliberately draws just the outer
-- top/bottom border to avoid wrap glitches, leaving the body raw.
vim.wo.wrap = false;
