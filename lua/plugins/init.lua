return {
	"nvim-lua/plenary.nvim",
	"nvim-treesitter/playground",
	"github/copilot.vim",
	"kyazdani42/nvim-web-devicons",
	"windwp/nvim-ts-autotag",
	"tpope/vim-sleuth",
	{
		"dmmulroy/tsc.nvim",
		config = function()
			require("tsc").setup()
			vim.keymap.set("n", "<leader>to", ":TSCOpen<CR>")
			vim.keymap.set("n", "<leader>tc", ":TSCClose<CR>")
		end,
	},
}
