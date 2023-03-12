safe_require('lualine', {
    options = {
        theme = "catppuccin",
        icons_enabled = true,
        section_separators = '',
        component_separators = {
            right = '▕',
            left = '▏',
        },
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {
            'branch',
            {
                'diff',
                colored = true,
                diff_color = {
                    added = 'DiffAdd',
                    modified = 'DiffChange',
                    removed = 'DiffDelete'
                },
                symbols = {added = '+', modified = '~', removed = '-'},
                source = nil,
            }
        },
        lualine_c = {'filename'},
        lualine_x = {'filetype'},
        lualine_y = {
            {
                'diagnostics',
                sources = { 'ale', 'coc' },
                sections = { 'error', 'warn', 'info', 'hint' },
                diagnostics_color = {
                  error = 'DiagnosticError',
                  warn  = 'DiagnosticWarn',
                  info  = 'DiagnosticInfo',
                  hint  = 'DiagnosticHint',
                },
                symbols = {error = 'E:', warn = 'W:', info = 'I:', hint = 'H:'},
                colored = true,
                update_in_insert = false,
                always_visible = true,
            }
        },
        lualine_z = {'location'},
    },
})

