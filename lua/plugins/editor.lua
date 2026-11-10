local map = vim.keymap.set

-- <CR> is mapped in user/completion.lua so it can also accept completions
require("nvim-autopairs").setup({
	check_ts = true,
	map_cr = false,
	ts_config = {
		lua = { "string" },
		javascript = { "template_string" },
		java = false,
	},
})

require("treesj").setup({})

require("flash").setup({})
map({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash" })
map({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })
map("o", "r", function()
	require("flash").remote()
end, { desc = "Remote Flash" })
map({ "o", "x" }, "R", function()
	require("flash").treesitter_search()
end, { desc = "Treesitter Search" })
map("c", "<c-s>", function()
	require("flash").toggle()
end, { desc = "Toggle Flash Search" })

local harpoon = require("harpoon")
harpoon:setup()
map("n", "<leader>a", function()
	harpoon:list():add()
end)
map("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
for i = 1, 5 do
	map("n", "<leader>" .. i, function()
		harpoon:list():select(i)
	end)
end

require("oil").setup({
	columns = { "icon" },
	use_default_keymaps = false,
	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<C-\\>"] = "actions.select_split",
		["<C-enter>"] = "actions.select_vsplit",
		["<C-t>"] = "actions.select_tab",
		["<C-p>"] = "actions.preview",
		["<C-c>"] = "actions.close",
		["<C-r>"] = "actions.refresh",
		["-"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
		["~"] = "actions.tcd",
		["gs"] = "actions.change_sort",
		["gx"] = "actions.open_external",
		["g."] = "actions.toggle_hidden",
	},
	view_options = { show_hidden = true },
})
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
map("n", "<space>-", require("oil").toggle_float)

require("todo-comments").setup({})
map("n", "<leader>tl", "<cmd>TodoLocList<CR>")

require("trouble").setup({})
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
map("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", {
	desc = "LSP Definitions / references / ... (Trouble)",
})
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

require("outline").setup({
	symbols = {
		icons = {
			File = { icon = "\u{ea7b}", hl = "@text.uri" },
			Module = { icon = "\u{eb29}", hl = "@namespace" },
			Namespace = { icon = "\u{ea8b}", hl = "@namespace" },
			Package = { icon = "\u{eb29}", hl = "@namespace" },
			Class = { icon = "\u{eb5b}", hl = "@type" },
			Method = { icon = "\u{192}", hl = "@method" },
			Property = { icon = "\u{eb65}", hl = "@method" },
			Field = { icon = "\u{eb5f}", hl = "@field" },
			Constructor = { icon = "\u{e20f}", hl = "@constructor" },
			Enum = { icon = "\u{ea95}", hl = "@type" },
			Interface = { icon = "\u{eb61}", hl = "@type" },
			Function = { icon = "\u{f09a}", hl = "@function" },
			Variable = { icon = "\u{ea88}", hl = "@constant" },
			Constant = { icon = "\u{e22c}", hl = "@constant" },
			String = { icon = "\u{eb8d}", hl = "@string" },
			Number = { icon = "#", hl = "@number" },
			Boolean = { icon = "\u{ea8f}", hl = "@boolean" },
			Array = { icon = "\u{ea8a}", hl = "@constant" },
			Object = { icon = "\u{ea8b}", hl = "@type" },
			Key = { icon = "\u{ea93}", hl = "@type" },
			Null = { icon = "\u{e299}", hl = "@type" },
			EnumMember = { icon = "\u{eb5e}", hl = "@field" },
			Struct = { icon = "\u{ea91}", hl = "@type" },
			Event = { icon = "\u{ea86}", hl = "@type" },
			Operator = { icon = "\u{eb64}", hl = "@operator" },
			TypeParameter = { icon = "\u{ea92}", hl = "@parameter" },
			Component = { icon = "\u{ea8c}", hl = "@function" },
			Fragment = { icon = "\u{eb5d}", hl = "@constant" },
		},
	},
})
map("n", "<leader>so", "<cmd>Outline<CR>", { desc = "[S]ymbols [O]utline" })

local macchiato = require("catppuccin.palettes").get_palette("macchiato")
vim.api.nvim_set_hl(0, "SpectreSearch", { bg = macchiato.red, fg = macchiato.base })
vim.api.nvim_set_hl(0, "SpectreReplace", { bg = macchiato.green, fg = macchiato.base })
require("spectre").setup({
	highlight = { search = "SpectreSearch", replace = "SpectreReplace" },
	mapping = {
		["send_to_qf"] = {
			map = "<C-q>",
			cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
			desc = "send all items to quickfix",
		},
	},
	replace_engine = {
		sed = { cmd = "sed", args = { "-i", "", "-E" } },
	},
})
map("n", "<leader>S", function()
	require("spectre").toggle()
end, { desc = "Toggle [S]pectre" })

require("tsc").setup()
map("n", "<leader>T", "<cmd>TSC<CR>")
map("n", "<leader>to", "<cmd>TSCOpen<CR>")
map("n", "<leader>tc", "<cmd>TSCClose<CR>")

require("colorizer").setup({ filetypes = { "*", css = { rgb_fn = true } } })

require("conform").setup({
	notify_on_error = false,
	format_on_save = function(bufnr)
		local no_lsp_fallback = { c = true, cpp = true }
		return {
			timeout_ms = 2500,
			lsp_format = no_lsp_fallback[vim.bo[bufnr].filetype] and "never" or "fallback",
		}
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { "biome", "prettierd", "prettier" },
		typescript = { "biome", "prettierd", "prettier" },
		javascriptreact = { "biome", "prettierd", "prettier" },
		typescriptreact = { "biome", "prettierd", "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
	},
})
map("", "<leader>f", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat buffer" })
