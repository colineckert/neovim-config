return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "auto", -- auto, main, moon, or dawn
				dark_variant = "main", -- main, moon, or dawn
				dim_inactive_windows = false,
				extend_background_behind_borders = true,

				enable = {
					terminal = true,
					legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},

				styles = {
					bold = true,
					italic = false,
					transparency = false,
				},

				highlight_groups = {
					Comment = { italic = true },
					["@keyword.conditional"] = { italic = true },
				},
			})
		end,
	},
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "auto", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false, -- disables setting the background color.
				show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
				term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = false, -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15, -- percentage of the shade to apply to the inactive window
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				no_underline = false, -- Force no underline
				-- styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				-- 	comments = { "italic" }, -- Change the style of comments
				-- 	conditionals = { "italic" },
				-- 	loops = {},
				-- 	functions = { "italic" },
				-- 	keywords = {},
				-- 	strings = {},
				-- 	variables = {},
				-- 	numbers = {},
				-- 	booleans = {},
				-- 	properties = {},
				-- 	types = {},
				-- 	operators = {},
				-- miscs = {}, -- Uncomment to turn off hard-coded styles
				-- },
				color_overrides = {},
				custom_highlights = {},
				default_integrations = true,
				integrations = {
					treesitter = true,
					cmp = true,
					gitsigns = true,
					markdown = true,
					nvimtree = false,
					notify = false,
					diffview = true,
					fidget = true,
					harpoon = true,
					mason = true,
					-- indent_blankline = {
					-- 	enabled = false,
					-- 	scope_color = "sapphire",
					-- 	colored_indent_levels = false,
					-- },
					mini = {
						enabled = true,
						indentscope_color = "sapphire",
					},
				},
			})
		end,
	},
}
