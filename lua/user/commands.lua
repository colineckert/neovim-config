-- Color scheme
-- Usage:
--   ColorMyPencils()                       -> rose-pine (transparent; terminal bg shows through)
--   ColorMyPencils("vague")                -> vague with its own background
--   ColorMyPencils("vague", "none")        -> force a transparent background
--   :Pencils vague #0f0f10                 -> same thing from the cmdline, no quotes needed
function ColorMyPencils(color, bg)
	vim.cmd.colorscheme(color or "rose-pine")

	if bg then
		vim.api.nvim_set_hl(0, "Normal", { bg = bg })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg })
	end
end

vim.api.nvim_create_user_command("Pencils", function(opts)
	ColorMyPencils(opts.fargs[1], opts.fargs[2])
end, { nargs = "*", complete = "color" })

vim.api.nvim_create_user_command("RotateWindows", function()
	local ignored_filetypes = { "neo-tree", "fidget", "Outline", "toggleterm", "qf", "notify" }
	local windows = vim.tbl_filter(function(win)
		local buf = vim.api.nvim_win_get_buf(win)
		return not vim.tbl_contains(ignored_filetypes, vim.bo[buf].filetype)
	end, vim.api.nvim_tabpage_list_wins(0))

	if #windows == 1 then
		vim.notify("There is no other window to rotate with.", vim.log.levels.ERROR)
	elseif #windows > 2 then
		vim.notify("You can only swap 2 open windows. Found " .. #windows .. ".", vim.log.levels.ERROR)
	elseif #windows == 2 then
		local first, second = vim.api.nvim_win_get_buf(windows[1]), vim.api.nvim_win_get_buf(windows[2])
		vim.api.nvim_win_set_buf(windows[1], second)
		vim.api.nvim_win_set_buf(windows[2], first)
	end
end, {})
