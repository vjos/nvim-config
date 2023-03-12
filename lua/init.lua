function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function require_setup(plugin, config)
	local loaded = require(plugin)
	loaded.setup(config)
	return loaded
end

function safe_require(plugin, config)
	config = config or {} 
	local success, value = pcall(require_setup, plugin, config)
	if success then
		return value
	else
		print('Warning: Plugin ' .. plugin ' not found.')
		return nil
	end
end

-- colour picker config
safe_require('color-picker', {})
map('n', '<C-c>', '<cmd>PickColor<cr>')
map('i', '<C-c>', '<cmd>PickColorInsert<cr>')

-- treesitter setup
local configs = safe_require('nvim-treesitter.configs', {
	ensure_installed = {
        'python', 'c_sharp', 'lua', 'c', 'vim',
    },
    highlight = {
        enable = true,
    },
    indent = {
        enable = false,
    },
})

-- indent-blankline setup
vim.opt.list = true

safe_require('indent_blankline', {
    -- show_end_of_line = true,
    -- space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    context_patterns = {
	    "declaration", "expression", "pattern", "primary_expression",
	    "statement", "switch_body"
    },
    filetype_exclude = {"NvimTree", "markdown"},
})

-- twilight config; combined with zen so needs to be set up first
local twi = safe_require('twilight', {
	context = 0,
	expand = {
        "function",
        "method",
        "method_definition",
        "table",
        "if_statement",
        "function_definition"
	}
})

map('n', '<Leader>n', '<cmd>Twilight<cr>')

-- true zen config
local true_zen = safe_require('true-zen', {
	integrations = {
		lightline = true,
	}
})

if true_zen and twi then
	true_zen.before_mode_ataraxis_on = function ()
		twi.disable()
	end
	true_zen.after_mode_ataraxis_on = function ()
		twi.enable()
	end
	true_zen.after_mode_ataraxis_off = function ()
		twi.disable()
	end
end

map('n', '<Leader>z', '<cmd>TZAtaraxis<cr>')

-- which-key.nvim config
safe_require('which-key', {})

-- vimtex mappings
map('n', '<Leader>ll', '<cmd>VimtexCompile<cr>')

-- FTerm setup
local term = safe_require('FTerm', {
	cmd = '/bin/bash',
	border = 'rounded',
})

-- gitsigns
safe_require("gitsigns", {})

-- catppuccin setup
safe_require("catppuccin", {})

vim.api.nvim_create_user_command('FTermOpen', term.open, {bang=true})
vim.api.nvim_create_user_command('FTermClose', term.close, {bang=true})
map('n', '<C-\\>', '<cmd>FTermOpen<cr>')
map('t', '<C-\\>', '<cmd>FTermClose<cr>')

