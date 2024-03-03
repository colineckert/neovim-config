return {
	"nvim-telescope/telescope.nvim",
	version = "0.1.4",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "debugloop/telescope-undo.nvim" },
	},
	config = function()
		local builtin = require("telescope.builtin")
		require("telescope").load_extension("undo")

		vim.keymap.set("n", "<leader>sh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>sf", builtin.find_files, {})
		vim.keymap.set("n", "<leader>sb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
		vim.keymap.set("n", "<leader>sr", builtin.resume, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>su", "<cmd>Telescope undo<cr>")
		vim.keymap.set("n", "<leader>sc", "<cmd>Telescope git_commits<cr>")

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })
	end,
}

-- REFERENCE
-- undo = {
--   mappings = {
--     i = {
--       ["<cr>"] = require("telescope-undo.actions").yank_additions,
--       ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
--       ["<C-cr>"] = require("telescope-undo.actions").restore,
--       -- alternative defaults, for users whose terminals do questionable things with modified <cr>
--       ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
--       ["<C-r>"] = require("telescope-undo.actions").restore,
--     },
--     n = {
--       ["y"] = require("telescope-undo.actions").yank_additions,
--       ["Y"] = require("telescope-undo.actions").yank_deletions,
--       ["u"] = require("telescope-undo.actions").restore,
--     },
--   },
-- },
