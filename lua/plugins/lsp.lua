return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{
				"utilyre/barbecue.nvim",
				name = "barbecue",
				version = "*",
				dependencies = {
					"SmiteshP/nvim-navic",
					"nvim-tree/nvim-web-devicons",
				},
				config = function()
					-- triggers CursorHold event faster
					vim.opt.updatetime = 200
					require("barbecue").setup({
						create_autocmd = false,
					})

					vim.api.nvim_create_autocmd({
						"WinResized",
						"BufWinEnter",
						"CursorHold",
						"InsertLeave",
						"BufModifiedSet",
					}, {
						group = vim.api.nvim_create_augroup("barbecue.updater", {}),
						callback = function()
							require("barbecue.ui").update()
						end,
					})
				end,
			},
		},
		---@class PluginLspOpts
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = false,
				update_in_insert = false,
				virtual_text = true,
				inlay_hints = {
					enable = true,
				},
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
							hint = { enable = true },
							runtime = {
								version = "LuaJIT",
							},
							diagnostics = {
								disable = { "missing-fields" },
							},
							workspace = {
								library = {
									vim.env.VIMRUNTIME,
									"${3rd}/luv/library",
								},
								checkThirdParty = false,
							},
							-- completion = {
							-- 	callSnippet = "Replace",
							-- },
							-- telemetry = {
							-- 	enable = false,
							-- },
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
				gopls = {
					init_options = {
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				},
				ts_ls = {
					init_options = {
						preferences = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
							importModuleSpecifierPreference = "non-relative",
						},
					},
				},
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
				marksman = {},
				markdown_oxide = {},
			},
			setup = {},
		},
		---@param opts PluginLspOpts
		config = function(_, opts)
			local lspUtils = require("utils.lsp")
			lspUtils.setDiagnosticsicon(opts.diagnostics)
			lspUtils.setLspKeymap()
			lspUtils.setFloatWindow()

			local lspconfig = require("lspconfig")
			local ensure_installed = {} ---@type string[]

			for server, config in pairs(opts.servers or {}) do
				-- add mason ensure install servers to a table
				ensure_installed[#ensure_installed + 1] = server
				config.on_attach = lspUtils.AttachFn

				-- setup lsp
				lspconfig[server].setup(config)
			end

			-- mason-lspconfig
			require("mason").setup({})
			require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
		end,
	},
	{
		"folke/lazydev.nvim",
		cond = function()
			local nvim_dir = vim.fn.finddir("snippets", vim.fn.getcwd() .. ";")
			if nvim_dir ~= "" then
				return true
			else
				return false
			end
		end,
		ft = "lua", -- only load on lua files
		opts = {},
	},
}
