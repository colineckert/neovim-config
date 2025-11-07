vim.opt.termguicolors = true

require("user")

-- Color scheme
function ColorMyPencils(color)
	color = color or "vague"

	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
