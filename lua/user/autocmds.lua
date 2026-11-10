local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("user", { clear = true })

autocmd("TextYankPost", {
	group = group,
	desc = "Highlight selection on yank",
	callback = function()
		vim.hl.on_yank({ timeout = 200, visual = true })
	end,
})

autocmd("FileType", {
	group = group,
	pattern = { "gitcommit", "markdown", "txt" },
	desc = "Enable spell checking and text wrapping for certain filetypes",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
		vim.opt_local.conceallevel = 2
	end,
})

-- Pickers, prompts and plugin panels are special buffers; as-you-type
-- completion there pops buffer words over the plugin's own UI.
autocmd({ "BufEnter", "FileType" }, {
	group = group,
	desc = "No autocompletion in special buffers",
	callback = function(ev)
		if vim.bo[ev.buf].buftype ~= "" then
			vim.bo[ev.buf].autocomplete = false
		end
	end,
})
