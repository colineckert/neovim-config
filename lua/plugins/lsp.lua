return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
		dependencies = {
			-- Plugin(s) and UI to automatically install LSPs to stdpath
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Install lsp autocompletions
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",

			-- Progress/Status update for LSP
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			local map_lsp_keybinds = function(buffer_number)
				-- NOTE: Remember that Lua is a real programming language, and as such it is possible
				-- to define small helper and utility functions so you don't have to repeat yourself.
				--
				-- In this case, we create a function that lets us more easily define mappings specific
				-- for LSP related items. It sets the mode, buffer and description for us each time.
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = buffer_number, desc = "LSP: " .. desc })
				end

				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-t>.
				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

				-- Find references for the word under your cursor.
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

				-- Fuzzy find all the symbols in your current document.
				--  Symbols are things like variables, functions, types, etc.
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

				-- Fuzzy find all the symbols in your current workspace.
				--  Similar to document symbols, except searches over your entire project.
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				-- Rename the variable under your cursor.
				--  Most Language Servers support renaming across files, etc.
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header.
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- Opens a popup that displays documentation about the word under your cursor
				--  See `:help K` for why this keymap
				map("K", vim.lsp.buf.hover, "Hover Documentation")
			end

			-- Default handlers for LSP
			local default_handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
			}

			local tsserver_inlay_hints = {
				includeInlayEnumMemberValueHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
			}

			-- Function to run when neovim connects to a Lsp client
			---@diagnostic disable-next-line: unused-local
			local on_attach = function(_client, buffer_number)
				-- Pass the current buffer to map lsp keybinds
				map_lsp_keybinds(buffer_number)
			end

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP Specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- LSP servers to install (see list here: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers )
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				-- LSP Servers
				bashls = {},
				cssls = {},
				eslint = {
					autostart = false,
					cmd = { "vscode-eslint-language-server", "--stdio", "--max-old-space-size=12288" },
					settings = {
						format = false,
					},
				},
				html = {},
				jsonls = {},
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								-- Tells lua_ls where to find all the Lua files that you have loaded
								-- for your neovim configuration.
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
							},
							telemetry = { enabled = false },
						},
					},
				},
				prismals = {},
				marksman = {},
				nil_ls = {},
				pyright = {},
				sqlls = {},
				tailwindcss = {},
				ts_ls = {
					settings = {
						maxTsServerMemory = 12288,
						typescript = {
							inlayHints = tsserver_inlay_hints,
						},
						javascript = {
							inlayHints = tsserver_inlay_hints,
						},
					},
				},
				gopls = {
					settings = {
						gopls = {
							analyses = {
								unusedparams = true,
							},
							staticcheck = true,
						},
					},
				},
				yamlls = {},
			}

			local formatters = {
				prettierd = {},
				stylua = {},
			}

			local manually_installed_servers = {}

			local mason_tools_to_install = vim.tbl_keys(vim.tbl_deep_extend("force", {}, servers, formatters))

			local ensure_installed = vim.tbl_filter(function(name)
				return not vim.tbl_contains(manually_installed_servers, name)
			end, mason_tools_to_install)

			require("mason-tool-installer").setup({
				auto_update = true,
				run_on_start = true,
				start_delay = 3000,
				debounce_hours = 12,
				ensure_installed = ensure_installed,
			})

			-- Iterate over our servers and set them up
			for name, config in pairs(servers) do
				require("lspconfig")[name].setup({
					autostart = config.autostart,
					cmd = config.cmd,
					capabilities = capabilities,
					filetypes = config.filetypes,
					handlers = vim.tbl_deep_extend("force", {}, default_handlers, config.handlers or {}),
					on_attach = on_attach,
					settings = config.settings,
					root_dir = config.root_dir,
				})
			end

			-- Setup mason so it can manage 3rd party LSP servers
			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})

			require("mason-lspconfig").setup()

			-- Configure borderd for LspInfo ui
			require("lspconfig.ui.windows").default_options.border = "rounded"

			-- Configure diagnostics border
			vim.diagnostic.config({
				float = {
					border = "rounded",
				},
			})
		end,
	},
}
