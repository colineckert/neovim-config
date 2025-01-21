return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		{ "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "copilot",
				},
				inline = {
					adapter = "copilot",
				},
			},
		})

		vim.api.nvim_set_keymap("n", "<C-x>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("v", "<C-x>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap(
			"n",
			"<leader>cc",
			"<cmd>CodeCompanionChat Toggle<cr>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"v",
			"<leader>cc",
			"<cmd>CodeCompanionChat Toggle<cr>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

		-- Expand 'cc' into 'CodeCompanion' in the command line
		vim.cmd([[cab cc CodeCompanion]])
	end,
}
