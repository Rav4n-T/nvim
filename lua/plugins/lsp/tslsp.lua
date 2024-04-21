local M = {
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
}

return M
