return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"folke/neodev.nvim",
				opts = {},
			},
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "hrsh7th/cmp-nvim-lsp" },
		},
		---@class PluginLspOpts
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = false,
				update_in_insert = false,
				virtual_text = false,
				float = {
					source = "always",
				},
				severity_sort = true,
			},
			-- LSP Server Settings
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							Lua = {
								diagnostics = {
									disable = { "missing-fields" },
								},
								workspace = {
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
				},
				-- clangd = {
				-- 	cmd = { "clangd", "--header-insertion=iwyu", "--clang-tidy" },
				-- 	root_dir = function(fname)
				-- 		return require("lspconfig.util").root_pattern(
				-- 			".clangd",
				-- 			".clang-tidy",
				-- 			".clang-format",
				-- 			"compile_commands.json",
				-- 			"compile_flags.txt",
				-- 			"configure.ac",
				-- 			".vs",
				-- 			".git"
				-- 		)(fname)
				-- 	end,
				-- 	single_file_support = true,
				-- },
				-- rust_analyzer = {
				-- 	settings = {
				-- 		["rust-analyzer"] = {
				-- 			imports = {
				-- 				granularity = {
				-- 					group = "module",
				-- 				},
				-- 				prefix = "self",
				-- 			},
				-- 			cargo = {
				-- 				buildScripts = {
				-- 					enable = true,
				-- 				},
				-- 			},
				-- 			procMacro = {
				-- 				enable = true,
				-- 			},
				-- 		},
				-- 	},
				-- },
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
				-- jsonls = {},
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
		config = function(_, opts)
			local lspUtils = require("utils.lsp")
			lspUtils.setDiagnosticsicon(opts.diagnostics)
			lspUtils.setLspKeymap()
			lspUtils.setFloatWindow()

			-- mason-lspconfig
			local servers = opts.servers
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
			local ensure_installed = {} ---@type string[]

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
					on_attach = lspUtils.AttachFn,
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
			require("mason-lspconfig").setup({ ensure_installed = ensure_installed, handlers = { setup } })
		end,
	},
}
