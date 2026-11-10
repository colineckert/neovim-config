-- Server definitions (cmd, filetypes, root markers) come from nvim-lspconfig's
-- lsp/*.lua files; this table only adds overrides and the Mason package name.
-- Every server here is enabled. The old config also enabled whatever Mason had
-- installed (mason-lspconfig's automatic_enable), so all of those are listed.
local ts_inlay_hints = {
	includeInlayEnumMemberValueHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayFunctionParameterTypeHints = true,
	includeInlayParameterNameHints = "all",
	includeInlayParameterNameHintsWhenArgumentMatchesName = true,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayVariableTypeHints = true,
	includeInlayVariableTypeHintsWhenTypeMatchesName = true,
}

local servers = {
	bashls = { mason = "bash-language-server" },
	biome = { mason = "biome" },
	cssls = { mason = "css-lsp" },
	emmet_language_server = { mason = "emmet-language-server" },
	gopls = { mason = "gopls" },
	pylsp = { mason = "python-lsp-server" },
	quick_lint_js = { mason = "quick-lint-js" },
	rubocop = { mason = "rubocop" },
	ruby_lsp = { mason = "ruby-lsp" },
	rust_analyzer = { mason = "rust-analyzer" },
	semgrep = { mason = "semgrep" },
	vimls = { mason = "vim-language-server" },
	eslint = {
		mason = "eslint-lsp",
		config = {
			cmd = { "vscode-eslint-language-server", "--stdio", "--max-old-space-size=12288" },
			settings = { format = false },
		},
	},
	html = { mason = "html-lsp" },
	jsonls = { mason = "json-lsp" },
	lua_ls = {
		mason = "lua-language-server",
		config = {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					workspace = {
						checkThirdParty = false,
						library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
					},
					telemetry = { enabled = false },
				},
			},
		},
	},
	marksman = { mason = "marksman" },
	prismals = { mason = "prisma-language-server" },
	pyright = { mason = "pyright" },
	sqlls = { mason = "sqlls" },
	tailwindcss = {
		mason = "tailwindcss-language-server",
		config = { filetypes = { "typescriptreact", "javascriptreact", "html" } },
	},
	ts_ls = {
		mason = "typescript-language-server",
		config = {
			settings = {
				maxTsServerMemory = 12288,
				typescript = { inlayHints = ts_inlay_hints },
				javascript = { inlayHints = ts_inlay_hints },
			},
		},
	},
	yamlls = { mason = "yaml-language-server" },
}

-- Formatters, linters and Go/Ruby tooling that were installed through Mason
local tools = {
	"delve",
	"erb-formatter",
	"erb-lint",
	"eslint_d",
	"gofumpt",
	"goimports-reviser",
	"golines",
	"gomodifytags",
	"gotests",
	"impl",
	"jq",
	"markdownlint",
	"prettier",
	"prettierd",
	"rubyfmt",
	"staticcheck",
	"stylua",
}

require("mason").setup()
require("mason-tool-installer").setup({
	-- Servers without a `mason` field are installed outside Mason (brew, npm, ...)
	ensure_installed = vim.list_extend(
		vim.iter(vim.tbl_values(servers))
			:map(function(server)
				return server.mason
			end)
			:totable(),
		tools
	),
	auto_update = true,
	run_on_start = true,
	start_delay = 3000,
	debounce_hours = 12,
})

for name, server in pairs(servers) do
	if server.config then
		vim.lsp.config(name, server.config)
	end
end
vim.lsp.enable(vim.tbl_keys(servers))

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "\u{f659} ",
			[vim.diagnostic.severity.WARN] = "\u{f529} ",
			[vim.diagnostic.severity.HINT] = "\u{f835} ",
			[vim.diagnostic.severity.INFO] = "\u{f449} ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
		},
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user_lsp", { clear = true }),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		local telescope = require("telescope.builtin")
		local function map(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
		end

		map("gd", telescope.lsp_definitions, "[G]oto [D]efinition")
		map("gr", telescope.lsp_references, "[G]oto [R]eferences")
		map("gI", telescope.lsp_implementations, "[G]oto [I]mplementation")
		map("<leader>D", telescope.lsp_type_definitions, "Type [D]efinition")
		map("<leader>ds", telescope.lsp_document_symbols, "[D]ocument [S]ymbols")
		map("<leader>ws", telescope.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		map("K", vim.lsp.buf.hover, "Hover Documentation")

		-- Accepting an item with <C-y> then applies snippets, auto-imports and other edits
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf)
		end
	end,
})
