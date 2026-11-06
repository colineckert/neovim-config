return {
	{
		"nvim-pack/nvim-spectre",
		lazy = true,
		cmd = { "Spectre" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>S",
				function()
					require("spectre").toggle()
				end,
				desc = "Toggle [S]pectre",
			},
		},
		config = function()
			vim.api.nvim_set_hl(0, "SpectreSearch", { bg = "#ed8796", fg = "#24273a" })
			vim.api.nvim_set_hl(0, "SpectreReplace", { bg = "#a6da95", fg = "#24273a" })

			require("spectre").setup({
				highlight = {
					search = "SpectreSearch",
					replace = "SpectreReplace",
				},
				mapping = {
					["send_to_qf"] = {
						map = "<C-q>",
						cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
						desc = "send all items to quickfix",
					},
				},
				replace_engine = {
					sed = {
						cmd = "sed",
						args = {
							"-i",
							"",
							"-E",
						},
					},
				},
			})
		end,
	},
}
