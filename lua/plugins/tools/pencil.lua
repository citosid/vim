return {
	"preservim/vim-pencil",
	ft = { "markdown" },
	config = function()
		vim.cmd([[
      augroup pencil
        autocmd!
        autocmd FileType markdown call pencil#init({'wrap': 'hard', 'autoformat': 1})
      augroup END
    ]])
	end,
}
