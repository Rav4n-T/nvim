return {
	{
		"luozhiya/fittencode.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			local utils = require("utils.cmp")
			require("fittencode").setup({
				inline_completion = {
					enable = false,
					disable_completion_within_the_line = true,
					disable_completion_when_delete = true,
					auto_triggering_completion = false,
					accept_mode = "commit",
				},
				chat = {
					highlight_conversation_at_cursor = false,
					style = "floating",
					floating = {
						border = "rounded",
						size = { width = 0.8, height = 0.8 },
					},
				},
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
				source_completion = {
					enable = true,
					engine = "cmp",
					trigger_chars = utils.fc_trigger_chars(),
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
}
