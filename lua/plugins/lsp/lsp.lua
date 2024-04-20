local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "hrsh7th/cmp-nvim-lsp" },
	},
	---@class PluginLspOpts
	opts = {
		-- options for vim.diagnostic.config()
		diagnostics = {
			underline = true,
			update_in_insert = false,
			virtual_text = { spacing = 2, prefix = ">" },
			severity_sort = true,
		},
		-- LSP Server Settings
		servers = {
			lua_ls = {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						completion = {
							callSnippet = "Replace",
						},
						telemetry = {
							enable = false,
						},
					},
				},
			},
			clangd = {
				cmd = { "clangd", "--header-insertion=iwyu", "--clang-tidy" },
				root_dir = function(fname)
					return require("lspconfig.util").root_pattern(
						".clangd",
						".clang-tidy",
						".clang-format",
						"compile_commands.json",
						"compile_flags.txt",
						"configure.ac",
						".vs",
						".git"
					)(fname)
				end,
				single_file_support = true,
			},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						imports = {
							granularity = {
								group = "module",
							},
							prefix = "self",
						},
						cargo = {
							buildScripts = {
								enable = true,
							},
						},
						procMacro = {
							enable = true,
						},
					},
				},
			},
			emmet_language_server = {
				init_options = {
					includeLanguages = { typescriptreact = "html" },
				},
			},
			-- tsserver = {},
			-- volar = {
			-- 	filetypes = { "vue" },
			-- 	init_options = {
			-- 		LanguageFeatures = {
			-- 			completion = {
			-- 				preferredTagNameCase = "kebab",
			-- 				preferredAttrNameCase = "camel",
			-- 			},
			-- 		},
			-- 	},
			-- },
			tailwindcss = {},
			jsonls = {},
			-- pyright = {},
			-- cssls = {
			-- 	filetypes = {
			-- 		"css",
			-- 		"scss",
			-- 		"less",
			-- 	},
			-- 	settings = {
			-- 		css = { validate = true, lint = { unknownAtRules = "ignore" } },
			-- 		less = { validate = true, lint = { unknownAtRules = "ignore" } },
			-- 		scss = { validate = true, lint = { unknownAtRules = "ignore" } },
			-- 	},
			-- 	single_file_support = true,
			-- },
		},
		setup = {},
	},
	---@param opts PluginLspOpts
	-- config = function(plugin, opts)
	config = function(_, opts)
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
		-- diagnostics
		for name, icon in pairs(require("core.options").icons.diagnostics) do
			name = "DiagnosticSign" .. name
			vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
		end
		vim.diagnostic.config(opts.diagnostics)

		-- mason-lspconfig
		local servers = opts.servers
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		local ensure_installed = {} ---@type string[]

		local function setup(server)
			local server_opts = vim.tbl_deep_extend("force", {
				capabilities = vim.deepcopy(capabilities),
			}, servers[server] or {})
			require("lspconfig")[server].setup(server_opts)
		end

		for server, _ in pairs(servers) do
			ensure_installed[#ensure_installed + 1] = server
		end

		require("mason").setup({
			ui = {
				border = "single",
				icons = {
					package_installed = " ",
					package_pending = " ",
					package_uninstalled = " ",
				},
			},
		})
		require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
		require("mason-lspconfig").setup_handlers({ setup })
	end,
}
return M
