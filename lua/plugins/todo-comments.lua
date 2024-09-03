return {
	"folke/todo-comments.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		require("todo-comments").setup({})
		-- see telescope.lua for the "<leader>st" search todo keymap
		vim.keymap.set("n", "<leader>tl", ":TodoLocList<CR>")
	end,
}
