local map = vim.keymap.set

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		section_separators = { left = "", right = "" },
		component_separators = { left = "\u{2502}", right = "\u{2502}" },
		always_divide_middle = true,
		globalstatus = true,
		refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			"diff",
			{
				"diagnostics",
				sources = { "nvim_diagnostic", "nvim_lsp", "vim_lsp" },
				sections = { "error", "warn", "info", "hint" },
				symbols = { error = "\u{f188} ", warn = "\u{f071} ", info = "\u{f449} ", hint = "\u{f0eb} " },
				colored = true,
				update_in_insert = false,
				always_visible = false,
			},
		},
		lualine_c = {
			{
				"filename",
				file_status = true,
				newfile_status = false,
				path = 4, -- filename and parent dir, with ~ for home
				shorting_target = 40,
				symbols = { modified = "[+]", readonly = "[-]", unnamed = "[No Name]", newfile = "[New]" },
			},
		},
		lualine_x = { "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_c = { "filename" },
		lualine_x = { "location" },
	},
	extensions = { "fugitive" },
})

require("fidget").setup({
	progress = { display = { progress_icon = { "dots_negative" } } },
})

local mocha = require("catppuccin.palettes").get_palette("mocha")
vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = mocha.sapphire })

require("snacks").setup({
	bigfile = { enabled = true },
	dim = { enabled = true },
	git = { enabled = true },
	gitbrowse = { enabled = true },
	indent = { enabled = false },
	input = { enabled = true },
	notifier = { enabled = true, timeout = 3000 },
	quickfile = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = false },
	zen = { enabled = true },
})

local filtered_messages = { ["No information available"] = true }
local notify = Snacks.notifier.notify
---@diagnostic disable-next-line: duplicate-set-field
Snacks.notifier.notify = function(message, level, opts)
	if not filtered_messages[message] then
		return notify(message, level, opts)
	end
end

map("n", "<leader>.", function()
	Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })
map("n", "<leader>B", function()
	Snacks.scratch.select()
end, { desc = "Select Scratch [B]uffer" })
map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "[B]uffer [D]elete" })
map("n", "<leader>gb", function()
	Snacks.git.blame_line()
end, { desc = "[G]it [B]lame Line" })
map({ "n", "v" }, "<leader>og", function()
	Snacks.gitbrowse()
end, { desc = "[O]pen [G]it" })
map("n", "<leader>nh", function()
	Snacks.notifier.show_history()
end, { desc = "[N]otification [H]istory" })
map("n", "<leader>dn", function()
	Snacks.notifier.hide()
end, { desc = "[D]ismiss All [N]otifications" })
map("n", "<leader>z", function()
	Snacks.toggle.dim():toggle()
end, { desc = "Toggle [Z]en Mode" })
map("n", "<leader>ln", function()
	Snacks.toggle.option("relativenumber", { name = "Relative Number" }):toggle()
end, { desc = "Toggle Relative [L]ine [N]umbers" })
map("n", "<leader>td", function()
	Snacks.toggle.diagnostics():toggle()
end, { desc = "[T]oggle [D]iagnostics" })
map("n", "<leader>tt", function()
	local tsc = require("treesitter-context")
	Snacks.toggle({
		name = "Treesitter Context",
		get = tsc.enabled,
		set = function(state)
			if state then
				tsc.enable()
			else
				tsc.disable()
			end
		end,
	}):toggle()
end, { desc = "[T]oggle [T]reesitter Context" })
