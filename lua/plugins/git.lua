local map = vim.keymap.set

require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = require("gitsigns")
		local function bmap(mode, lhs, rhs, opts)
			opts = opts or {}
			opts.buffer = bufnr
			map(mode, lhs, rhs, opts)
		end

		bmap({ "n", "v" }, "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gs.nav_hunk("next")
			end
		end, { desc = "Jump to next hunk" })
		bmap({ "n", "v" }, "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gs.nav_hunk("prev")
			end
		end, { desc = "Jump to previous hunk" })

		bmap("v", "<leader>hs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "stage git hunk" })
		bmap("v", "<leader>hr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "reset git hunk" })
		bmap("n", "<leader>hs", gs.stage_hunk, { desc = "git stage hunk" })
		bmap("n", "<leader>hr", gs.reset_hunk, { desc = "git reset hunk" })
		bmap("n", "<leader>hS", gs.stage_buffer, { desc = "git Stage buffer" })
		bmap("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
		bmap("n", "<leader>hR", gs.reset_buffer, { desc = "git Reset buffer" })
		bmap("n", "<leader>hp", gs.preview_hunk, { desc = "preview git hunk" })
		bmap("n", "<leader>hb", function()
			gs.blame_line({ full = false })
		end, { desc = "git blame line" })
		bmap("n", "<leader>hd", gs.diffthis, { desc = "git diff against index" })
		bmap("n", "<leader>hD", function()
			gs.diffthis("~")
		end, { desc = "git diff against last commit" })
		bmap("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
		bmap("n", "<leader>td", gs.toggle_deleted, { desc = "toggle git show deleted" })
		bmap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
	end,
})

map("n", "<leader>gs", vim.cmd.Git, { desc = "Git [S]tatus" })

require("diffview").setup({ diff_binaries = false })
map("n", "<leader>df", "<cmd>DiffviewFileHistory<CR>")
map("n", "<leader>do", "<cmd>DiffviewOpen<CR>")
map("n", "<leader>dc", "<cmd>DiffviewClose<CR>")
