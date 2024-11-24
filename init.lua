local start_time = vim.loop.hrtime()
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
require("options")
require("lazy").setup({
	spec = "plugins",
	change_detection = {
		notify = false,
	},
})
require("keymaps")
require("autocmds")

local end_time = vim.loop.hrtime()
local elapsed_ms = (end_time - start_time) / 1e6 -- Convert nanoseconds to milliseconds
vim.defer_fn(function()
	vim.notify(string.format("Neovim loaded in %.2f ms", elapsed_ms), vim.log.levels.INFO)
end, 100)
