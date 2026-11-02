vim.opt.termguicolors = true

require("user")

-- Color scheme
function ColorMyPencils(color)
	color = color or "vague"

	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

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
