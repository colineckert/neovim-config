return {
	"nvim-treesitter/playground",
	"kyazdani42/nvim-web-devicons",
	"windwp/nvim-ts-autotag",
	"tpope/vim-sleuth",
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "codecompanion" },
	},
	{
		"Wansmer/treesj",
		keys = { "<space>m" },
		dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
		config = function()
			require("treesj").setup({--[[ your config ]]
			})
		end,
	},
}
