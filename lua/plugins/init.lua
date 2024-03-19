return {
	"nvim-lua/plenary.nvim",
	"nvim-treesitter/playground",
	"github/copilot.vim",
	"kyazdani42/nvim-web-devicons",
	"windwp/nvim-ts-autotag",
	"tpope/vim-sleuth",
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "github/copilot.vim" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			debug = true, -- Enable debugging
			mappings = {
				close = "q",
				reset = "<C-q>",
				complete = "<Tab>",
				submit_prompt = "<CR>",
				accept_diff = "<C-y>",
				show_diff = "gd",
				show_system_prompt = "gp",
				show_user_selection = "gs",
			},
			-- window = {
			-- 	layout = "float",
			-- 	relative = "cursor",
			-- 	width = 1,
			-- 	height = 0.4,
			-- 	row = 1,
			-- },
		},
		keys = {
			{
				"<leader>ccq",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
					end
				end,
				desc = "CopilotChat - Quick chat",
			},
			{
				"<leader>cch",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.help_actions())
				end,
				desc = "CopilotChat - Help actions",
			},
			-- Show prompts actions with telescope
			{
				"<leader>ccp",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				desc = "CopilotChat - Prompt actions",
			},
		},
	},
}
