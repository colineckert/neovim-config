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

		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>sS", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
		vim.keymap.set("n", "<leader>su", "<cmd>Telescope undo<cr>", { desc = "[S]earch [U]ndo" })
		vim.keymap.set("n", "<leader>sc", "<cmd>Telescope git_commits<cr>", { desc = "[S]earch [C]ommits" })
		vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "[S]earch [T]odo" })

		vim.keymap.set(
			"n",
			"<leader>bs",
			require("telescope.builtin").lsp_document_symbols,
			{ desc = "LSP: [B]uffer [S]ymbols" }
		)

		vim.keymap.set(
			"n",
			"<leader>ws",
			require("telescope.builtin").lsp_workspace_symbols,
			{ desc = "LSP: [W]orkspace [S]ymbols" }
		)

		vim.keymap.set("n", "<leader>ss", function()
			builtin.lsp_dynamic_workspace_symbols({ symbols = { "function", "method" } })
		end, { desc = "[S]earch [S]ymbols" })

		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- Also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching your neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
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
