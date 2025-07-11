return {
	{
		"github/copilot.vim",
		config = function()
			vim.keymap.set("i", "<C-Y>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
			})
			-- Add <C-o> to accept the next token
			vim.keymap.set("i", "<C-o>", "copilot#AcceptWord()", {
				expr = true,
				replace_keycodes = false,
			})
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_model = "claude-3.7-sonnet-thought"
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		cmd = { "Copilot", "CopilotChat" },
		dependencies = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		config = function()
			require("CopilotChat").setup({
				model = "claude-3.7-sonnet-thought",
			})
		end,
	},
}
