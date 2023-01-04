require("ceckert.set")
require("ceckert.remap")

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
	options = {
		icons_enabled = false,
		theme = 'auto',
		component_separators = '|',
		section_separators = '',
	},
}
-- Enable autotag
require('nvim-ts-autotag').setup()

-- Enable Comment.nvim
require('Comment').setup()

