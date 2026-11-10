local map = vim.keymap.set

-- copilot.vim reads these when its plugin/ file loads, right after init.lua.
-- <C-j>, <C-k> and <C-y> are shared with the completion menu: user/completion.lua.
vim.g.copilot_filetypes = { TelescopePrompt = false }
vim.g.copilot_assume_mapped = true
vim.g.copilot_workspace_folders = "~/Developer/"

map("i", "<C-i>", "<Plug>(copilot-accept-line)", { silent = true })
map("i", "<C-l>", "<Plug>(copilot-suggest)", { silent = true })
map("i", "<C-d>", "<Plug>(copilot-dismiss)", { silent = true })

require("codecompanion").setup({
	interactions = {
		chat = { adapter = "copilot" },
		inline = { adapter = "copilot" },
	},
})

map("n", "<leader>ai", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle Code Companion chat", silent = true })
map("x", "<leader>ai", "<cmd>'<,'>CodeCompanion<cr>", {
	desc = "Prompt Code Companion on the current selection",
	silent = true,
})
vim.cmd.cabbrev("cc CodeCompanion")
