-- nvim-treesitter's `main` branch only installs parsers and queries.
-- Highlighting is Neovim's own (vim.treesitter.start); indentation stays here.
local ts = require("nvim-treesitter")

ts.install({
	"bash",
	"css",
	"dockerfile",
	"gitignore",
	"go",
	"html",
	"javascript",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"prisma",
	"query",
	"tsx",
	"typescript",
	"vim",
	"yaml",
})

local function attach(buf, lang)
	if not vim.api.nvim_buf_is_valid(buf) then
		return
	end
	vim.treesitter.start(buf, lang)
	vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

local available
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
	desc = "Start treesitter, installing the parser on first use",
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(ev.match)
		if not lang then
			return
		end
		if vim.treesitter.language.add(lang) then
			attach(ev.buf, lang)
			return
		end
		available = available or ts.get_available()
		if vim.tbl_contains(available, lang) then
			ts.install(lang):await(vim.schedule_wrap(function()
				if vim.treesitter.language.add(lang) then
					attach(ev.buf, lang)
				end
			end))
		end
	end,
})

require("nvim-treesitter-textobjects").setup({
	select = { lookahead = true },
	move = { set_jumps = true },
})

local select = require("nvim-treesitter-textobjects.select")
for lhs, query in pairs({
	af = "@function.outer",
	["if"] = "@function.inner",
	ac = "@class.outer",
	ic = "@class.inner",
}) do
	vim.keymap.set({ "x", "o" }, lhs, function()
		select.select_textobject(query, "textobjects")
	end)
end

local move = require("nvim-treesitter-textobjects.move")
for fn, maps in pairs({
	goto_next_start = { ["]f"] = "@function.outer", ["]]"] = "@class.outer" },
	goto_next_end = { ["]F"] = "@function.outer", ["]["] = "@class.outer" },
	goto_previous_start = { ["[f"] = "@function.outer", ["[["] = "@class.outer" },
	goto_previous_end = { ["[F"] = "@function.outer", ["[]"] = "@class.outer" },
}) do
	for lhs, query in pairs(maps) do
		vim.keymap.set({ "n", "x", "o" }, lhs, function()
			move[fn](query, "textobjects")
		end)
	end
end

require("treesitter-context").setup()
require("nvim-ts-autotag").setup()
