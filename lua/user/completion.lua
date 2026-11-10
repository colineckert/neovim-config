-- Insert-mode keys shared by the completion menu, Copilot and autopairs.
-- Each key acts on the menu when it is open and falls through otherwise,
-- which is how nvim-cmp's mappings behaved.
local map = vim.keymap.set
local keycode = vim.keycode

local function menu_open()
	return vim.fn.pumvisible() == 1
end

local function item_selected()
	return vim.fn.complete_info({ "selected" }).selected ~= -1
end

map("i", "<C-j>", function()
	return menu_open() and "<C-n>" or "<Plug>(copilot-next)"
end, { expr = true, remap = true, silent = true, desc = "Next completion / Copilot suggestion" })

map("i", "<C-k>", function()
	return menu_open() and "<C-p>" or "<Plug>(copilot-previous)"
end, { expr = true, remap = true, silent = true, desc = "Previous completion / Copilot suggestion" })

map("i", "<C-y>", function()
	if menu_open() then
		return keycode("<C-y>")
	end
	return vim.fn["copilot#Accept"]("\r")
end, { expr = true, replace_keycodes = false, desc = "Accept completion / Copilot suggestion" })

map("i", "<CR>", function()
	local autopairs = require("nvim-autopairs")
	if menu_open() then
		if item_selected() then
			return keycode("<C-y>")
		end
		return keycode("<C-e>") .. autopairs.autopairs_cr()
	end
	return autopairs.autopairs_cr()
end, { expr = true, replace_keycodes = false, desc = "Accept selected completion or newline" })

map("i", "<C-Space>", vim.lsp.completion.get, { desc = "Trigger completion" })
