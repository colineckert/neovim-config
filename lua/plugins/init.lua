local function gh(repo, opts)
	return vim.tbl_extend("force", { src = "https://github.com/" .. repo }, opts or {})
end

-- Must be registered before vim.pack.add so it also fires on first install.
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

vim.pack.add({
	-- Colorschemes
	gh("rose-pine/neovim", { name = "rose-pine" }),
	gh("catppuccin/nvim", { name = "catppuccin" }),
	gh("vague-theme/vague.nvim"),

	-- Shared dependencies
	gh("nvim-lua/plenary.nvim"),
	gh("nvim-tree/nvim-web-devicons"),

	-- Treesitter
	gh("nvim-treesitter/nvim-treesitter", { version = "main" }),
	gh("nvim-treesitter/nvim-treesitter-textobjects", { version = "main" }),
	gh("nvim-treesitter/nvim-treesitter-context"),
	gh("windwp/nvim-ts-autotag"),

	-- LSP servers and tools
	gh("neovim/nvim-lspconfig"),
	gh("mason-org/mason.nvim"),
	gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
	gh("j-hui/fidget.nvim"),
	gh("stevearc/conform.nvim"),

	-- Search
	gh("nvim-telescope/telescope.nvim"),
	gh("debugloop/telescope-undo.nvim"),
	gh("nvim-pack/nvim-spectre"),

	-- Editing and navigation
	gh("windwp/nvim-autopairs"),
	gh("Wansmer/treesj"),
	gh("tpope/vim-sleuth"),
	gh("folke/flash.nvim"),
	gh("ThePrimeagen/harpoon", { version = "harpoon2" }),
	gh("stevearc/oil.nvim"),
	gh("christoomey/vim-tmux-navigator"),
	gh("folke/todo-comments.nvim"),
	gh("folke/trouble.nvim"),
	gh("hedyhli/outline.nvim"),
	gh("dmmulroy/tsc.nvim"),
	gh("catgoose/nvim-colorizer.lua"),

	-- Git
	gh("lewis6991/gitsigns.nvim"),
	gh("tpope/vim-fugitive"),
	gh("sindrets/diffview.nvim"),

	-- UI
	gh("nvim-lualine/lualine.nvim"),
	gh("folke/snacks.nvim"),
	gh("MeanderingProgrammer/render-markdown.nvim"),

	-- AI
	gh("github/copilot.vim"),
	gh("olimorris/codecompanion.nvim"),
}, { confirm = false })

for _, module in ipairs({ "colorscheme", "treesitter", "telescope", "editor", "git", "ui", "ai" }) do
	require("plugins." .. module)
end
