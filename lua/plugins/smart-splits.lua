return {
	"mrjones2014/smart-splits.nvim",
	event = "BufReadPre",
	lazy = true,
	opts = { ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" }, ignored_buftypes = { "nofile" } },
}
