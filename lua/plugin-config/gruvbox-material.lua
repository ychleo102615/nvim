-- https://github.com/sainnhe/gruvbox-material/blob/master/doc/gruvbox-material.txt
vim.cmd [[
        " Important!!
        if has('termguicolors')
          set termguicolors
        endif
        " For dark version.
        set background=dark
        " For light version.
        " set background=light
        " Set contrast.
        " This configuration option should be placed before `colorscheme gruvbox-material`.
        " Available values: 'hard', 'medium'(default), 'soft'
        let g:gruvbox_material_background = 'soft'
        " For better performance
        let g:gruvbox_material_better_performance = 1
]];
