-- https://github.com/lewis6991/gitsigns.nvim
local function on_attach(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true, desc = "Next [C]Hunk" })

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true, desc = "Prev [C]Hunk" })

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>'       , { desc = "Stage Hunk" })
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>'       , { desc = "Reset Hunk" })
    map('n', '<leader>hS', gs.stage_buffer                         , { desc = "Stage Buffer" })
    map('n', '<leader>hu', gs.undo_stage_hunk                      , { desc = "Undo Stage Hunk" })
    map('n', '<leader>hR', gs.reset_buffer                         , { desc = "Reset Buffer" })
    map('n', '<leader>hp', gs.preview_hunk                         , { desc = "Prview Hunk" })
    map('n', '<leader>hb', function() gs.blame_line{full=true} end , { desc = "Blame Line" })
    map('n', '<leader>tb', gs.toggle_current_line_blame            , { desc = "Toggle Line Blame" })
    map('n', '<leader>td', gs.toggle_deleted                       , { desc = "Toggle Deleted Hunk View" })
    map('n', '<leader>hD', gs.diffthis                             , { desc = "Diff This" })
    map('n', '<leader>hd',
        function()
            gs.diffthis('~' .. ((vim.v.count > 0) and vim.v.count or ''))
        end,
    { desc = "Diff This With Head" })

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select Hunk" })
    map('n', '<leader>ih', gs.select_hunk, { desc = "Select Hunk" })
end

return {
    {
        'lewis6991/gitsigns.nvim',
        event = "BufReadPre",
        opts = {
            signs = {
                add          = { text = "▎",  },
                change       = { text = "▎",  },
                delete       = { text = "契", },
                topdelete    = { text = "契", },
                changedelete = { text = "▎",  },
                untracked    = { text = '┆',  },
            },
            signs_staged = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 100,
            },
            current_line_blame_formatter = '      <author>, <author_time:%Y-%m-%d %H:%M:%S, %R> - <summary>',
            on_attach = on_attach,
        },
    },
};
