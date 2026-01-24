-- tests/formatters_spec.lua

describe("formatters", function()
	describe("utils", function()
		local utils

		before_each(function()
			package.loaded["formatters.utils"] = nil
			utils = require("formatters.utils")
		end)

		it("exports format_with_cmd function", function()
			assert.is_function(utils.format_with_cmd)
		end)

		it("exports cmd_exists function", function()
			assert.is_function(utils.cmd_exists)
		end)

		it("cmd_exists returns true for existing commands", function()
			assert.is_true(utils.cmd_exists("ls"))
		end)

		it("cmd_exists returns false for non-existing commands", function()
			assert.is_false(utils.cmd_exists("nonexistent_command_xyz"))
		end)
	end)

	describe("init", function()
		local formatters

		before_each(function()
			package.loaded["formatters"] = nil
			formatters = require("formatters")
		end)

		it("exports setup function", function()
			assert.is_function(formatters.setup)
		end)

		it("creates ExternalFormatters augroup on setup", function()
			formatters.setup()
			local ok = pcall(vim.api.nvim_get_autocmds, { group = "ExternalFormatters" })
			assert.is_true(ok)
		end)
	end)

	describe("biome", function()
		local biome

		before_each(function()
			package.loaded["formatters.biome"] = nil
			biome = require("formatters.biome")
		end)

		it("exports setup function", function()
			assert.is_function(biome.setup)
		end)
	end)

	describe("stylua", function()
		local stylua

		before_each(function()
			package.loaded["formatters.stylua"] = nil
			stylua = require("formatters.stylua")
		end)

		it("exports setup function", function()
			assert.is_function(stylua.setup)
		end)
	end)

	describe("black", function()
		local black

		before_each(function()
			package.loaded["formatters.black"] = nil
			black = require("formatters.black")
		end)

		it("exports setup function", function()
			assert.is_function(black.setup)
		end)
	end)

	describe("beautysh", function()
		local beautysh

		before_each(function()
			package.loaded["formatters.beautysh"] = nil
			beautysh = require("formatters.beautysh")
		end)

		it("exports setup function", function()
			assert.is_function(beautysh.setup)
		end)
	end)
end)
