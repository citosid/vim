return {
	"MeanderingProgrammer/render-markdown.nvim",
	opts = {
		file_types = { "markdown", "Avante" },
	},
	ft = { "markdown", "Avante" },
	config = function()
		require("render-markdown").setup({
			checkbox = {
				custom = {
					incomplete = {
						raw = "[/]",
						rendered = "󱎖 ",
						highlight = "RenderMarkdownTodo",
						scope_highlight = nil,
					},
					done = {
						raw = "[x]",
						rendered = "󰄬 ",
						highlight = "RenderMarkdownDone",
						scope_highlight = "@text.emphasis",
					},
					canceled = {
						raw = "[-]",
						rendered = "󰜺 ",
						highlight = "RenderMarkdownCanceled",
						scope_highlight = "@markup.strikethrough",
					},
					forwarded = {
						raw = "[>]",
						rendered = " ",
						highlight = "RenderMarkdownForwarded",
						scope_highlight = nil,
					},
					scheduling = {
						raw = "[<]",
						rendered = "󱓵 ",
						highlight = "RenderMarkdownScheduling",
						scope_highlight = nil,
					},
					question = {
						raw = "[?]",
						rendered = " ",
						highlight = "RenderMarkdownQuestion",
						scope_highlight = nil,
					},
					important = {
						raw = "[!]",
						rendered = " ",
						highlight = "DiagnosticWarn",
						scope_highlight = "DiagnosticWarn",
					},
					star = {
						raw = "[*]",
						rendered = " ",
						highlight = "RenderMarkdownStar",
						scope_highlight = nil,
					},
					quote = {
						raw = '["]',
						rendered = "󰇾 ",
						highlight = "RenderMarkdownQuote",
						scope_highlight = nil,
					},
					location = {
						raw = "[l]",
						rendered = "󰋘 ",
						highlight = "RenderMarkdownLocation",
						scope_highlight = nil,
					},
					bookmark = {
						raw = "[b]",
						rendered = "󰘘 ",
						highlight = "RenderMarkdownBookmark",
						scope_highlight = nil,
					},
					information = {
						raw = "[i]",
						rendered = " ",
						highlight = "RenderMarkdownInformation",
						scope_highlight = nil,
					},
					savings = {
						raw = "[S]",
						rendered = "󰮯 ",
						highlight = "RenderMarkdownSavings",
						scope_highlight = nil,
					},
					idea = {
						raw = "[I]",
						rendered = "󰍞 ",
						highlight = "RenderMarkdownIdea",
						scope_highlight = nil,
					},
					pros = {
						raw = "[p]",
						rendered = " ",
						highlight = "RenderMarkdownPros",
						scope_highlight = nil,
					},
					cons = {
						raw = "[c]",
						rendered = "󰍻 ",
						highlight = "RenderMarkdownCons",
						scope_highlight = nil,
					},
					fire = {
						raw = "[f]",
						rendered = "󰀽 ",
						highlight = "RenderMarkdownFire",
						scope_highlight = nil,
					},
					key = {
						raw = "[k]",
						rendered = "󰌌 ",
						highlight = "RenderMarkdownKey",
						scope_highlight = nil,
					},
					win = {
						raw = "[w]",
						rendered = "󰕣 ",
						highlight = "RenderMarkdownWin",
						scope_highlight = nil,
					},
					up = {
						raw = "[u]",
						rendered = "󰁝 ",
						highlight = "RenderMarkdownUp",
						scope_highlight = nil,
					},
					down = {
						raw = "[d]",
						rendered = "󰁡 ",
						highlight = "RenderMarkdownDown",
						scope_highlight = nil,
					},
				},
			},
		})
	end,
}
