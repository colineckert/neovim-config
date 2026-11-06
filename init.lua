vim.opt.termguicolors = true

require("user")

-- Color scheme
-- Usage:
--   ColorMyPencils()                       -> rose-pine (transparent; terminal bg shows through)
--   ColorMyPencils("vague")                -> vague with its own background
--   ColorMyPencils("vague", "none")        -> force a transparent background
--   :Pencils vague #0f0f10                 -> same thing from the cmdline, no quotes needed
function ColorMyPencils(color, bg)
	color = color or "rose-pine"

	vim.cmd.colorscheme(color)

	if bg then
		vim.api.nvim_set_hl(0, "Normal", { bg = bg })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg })
	end
end

vim.api.nvim_create_user_command("Pencils", function(opts)
	ColorMyPencils(opts.fargs[1], opts.fargs[2])
end, { nargs = "*", complete = "color" })

-- local function sync_system_background()
-- 	local result = vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
-- 	local background = result:match("Dark") and "dark" or "light"
--
-- 	if vim.o.background ~= background then
-- 		vim.o.background = background
-- 		vim.cmd.colorscheme("rose-pine")
-- 	end
-- end
--
-- sync_system_background()
--
-- vim.api.nvim_create_autocmd("FocusGained", {
-- 	callback = sync_system_background,
-- })

ColorMyPencils()
