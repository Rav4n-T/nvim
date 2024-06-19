return {
	{
		"Exafunction/codeium.nvim",
		event = "InsertEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
	},
	{
		"luozhiya/fittencode.nvim",
		config = function()
			require("fittencode").setup({
				use_default_keymaps = false,
				keymaps = {
					chat = {
						["q"] = "close",
						["[c"] = "goto_previous_conversation",
						["]c"] = "goto_next_conversation",
						["c"] = "copy_conversation",
						["C"] = "copy_all_conversations",
						["d"] = "delete_conversation",
						["D"] = "delete_all_conversations",
					},
				},
				completion_mode = "source",
			})
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {
			settings = {
				expose_as_code_action = "all",
				tsserver_max_memory = "auto",
				complete_function_calls = false,
				include_completions_with_insert_text = false,
				separate_diagnostic_server = false,
				tsserver_file_preferences = {
					disableSuggestions = false,
					quotePreference = "auto", -- auto | double | single
					-- Complete
					includeCompletionsForModuleExports = true,
					includeCompletionsForImportStatements = true,
					includeCompletionsWithInsertText = true,
					includeCompletionsWithSnippetText = true,
					includeCompletionsWithClassMemberSnippets = true,
					includeCompletionsWithObjectLiteralMethodSnippets = true,
					includeAutomaticOptionalChainCompletions = true,
					useLabelDetailsInCompletionEntries = true,
					allowIncompleteCompletions = true,
					importModuleSpecifierPreference = "shortest", -- "shortest" | "project-relative" | "relative" | "non-relative",
					-- /** Determines whether we import `foo/index.ts` as "foo", "foo/index", or "foo/index.js" */
					importModuleSpecifierEnding = "auto", --"auto" | "minimal" | "index" | "js",
					allowTextChangesInNewFiles = true,
					lazyConfiguredProjectsFromExternalProject = true,
					providePrefixAndSuffixTextForRename = true,
					provideRefactorNotApplicableReason = true,
					allowRenameOfImportPath = true,
					includePackageJsonAutoImports = "auto", -- "auto" | "on" | "off",
					jsxAttributeCompletionStyle = "auto", -- "auto" | "braces" | "none",

					displayPartsForJSDoc = true,
					generateReturnInDocTemplate = true,

					includeInlayParameterNameHints = "all", -- "none" | "literals" | "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
					-- autoImportFileExcludePatterns = string[],
				},
			},
		},
	},
	-- {
	-- 	"ray-x/go.nvim",
	-- 	dependencies = { -- optional packages
	-- 		"ray-x/guihua.lua",
	-- 		"neovim/nvim-lspconfig",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 	},
	-- 	ft = { "go", "gomod" },
	-- 	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	-- 	-- opts = {
	-- 	-- 	verbose = true,
	-- 	-- 	log_path = "/tmp/go.log",
	-- 	-- },
	-- 	config = true,
	-- },
}
