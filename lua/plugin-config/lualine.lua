-- https://github.com/nvim-lualine/lualine.nvim
require('lualine').setup {
    options = {
        theme = 'gruvbox-material',
        -- theme = 'seoul256',
        -- theme = 'everforest',
        -- theme = 'gruvbox',
        -- theme = 'wombat',
        -- theme = 'gruvbox_light',
        -- theme = require'lualine.themes.gruvbox',
    },
    winbar = {
        lualine_a = {
            { 'filename',
                file_status    = true,  -- Displays file status (readonly status, modified status)
                newfile_status = false, -- Display new file status (new file means no write after created)
                path = 1,  -- 0: Just the filename
                           -- 1: Relative path
                           -- 2: Absolute path
                           -- 3: Absolute path, with tilde as the home directory
                symbols = {
                    modified = '[+]',   -- Text to show when the file is modified.
                    readonly = '[-]',   -- Text to show when the file is non-modifiable or readonly.
                    unnamed  = '',      -- Text to show for unnamed buffers.
                    newfile  = '[New]', -- Text to show for new created file before first writting
                },
            },
        },
    },
    inactive_winbar = {
        lualine_b = {
            { 'filename',
                file_status    = true,
                newfile_status = false,
                path = 1,
                symbols = {
                    modified = '[+]',
                    readonly = '[-]',
                    unnamed  = '[No Name]',
                    newfile  = '[New]',
                },
            },
        },
    },
    -- tabline = {
    --     lualine_c = {
    --         { 'tabs',
    --             max_length = vim.o.columns / 3, -- Maximum width of tabs component.
    --             -- Note:
    --             -- It can also be a function that returns
    --             -- the value of `max_length` dynamically.
    --             mode = 2, -- 0: Shows tab_nr
    --             -- 1: Shows tab_name
    --             -- 2: Shows tab_nr + tab_name
    --
    --             tabs_color = {
    --                 -- Same values as the general color option can be used here.
    --                 active = 'lualine_{section}_normal',     -- Color for active tab.
    --                 inactive = 'lualine_{section}_inactive', -- Color for inactive tab.
    --             },
    --         },
    --     },
    -- },
};
