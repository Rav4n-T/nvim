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
				},
			})
		end,
	},
}
