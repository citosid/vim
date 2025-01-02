local M = {}

-- Convert bible reference to numerical ID
local function get_reference_id(text)
	local books = {}
	books["Gen"] = "1"
	books["Exod"] = "2"
	books["Lev"] = "3"
	books["Num"] = "4"
	books["Deut"] = "5"
	books["Josh"] = "6"
	books["Judg"] = "7"
	books["Ruth"] = "8"
	books["1Sam"] = "9"
	books["2Sam"] = "10"
	books["1Kgs"] = "11"
	books["2Kgs"] = "12"
	books["1Chr"] = "13"
	books["2Chr"] = "14"
	books["Ezra"] = "15"
	books["Neh"] = "16"
	books["Esth"] = "17"
	books["Job"] = "18"
	books["Ps"] = "19"
	books["Prov"] = "20"
	books["Eccl"] = "21"
	books["Song"] = "22"
	books["Isa"] = "23"
	books["Jer"] = "24"
	books["Lam"] = "25"
	books["Ezek"] = "26"
	books["Dan"] = "27"
	books["Hos"] = "28"
	books["Joel"] = "29"
	books["Amos"] = "30"
	books["Obad"] = "31"
	books["Jonah"] = "32"
	books["Mic"] = "33"
	books["Nah"] = "34"
	books["Hab"] = "35"
	books["Zeph"] = "36"
	books["Hag"] = "37"
	books["Zech"] = "38"
	books["Mal"] = "39"
	books["Matt"] = "40"
	books["Mark"] = "41"
	books["Luke"] = "42"
	books["John"] = "43"
	books["Acts"] = "44"
	books["Rom"] = "45"
	books["1Cor"] = "46"
	books["2Cor"] = "47"
	books["Gal"] = "48"
	books["Eph"] = "49"
	books["Phil"] = "50"
	books["Col"] = "51"
	books["1Thess"] = "52"
	books["2Thess"] = "53"
	books["1Tim"] = "54"
	books["2Tim"] = "55"
	books["Titus"] = "56"
	books["Phlm"] = "57"
	books["Heb"] = "58"
	books["Jas"] = "59"
	books["1Pet"] = "60"
	books["2Pet"] = "61"
	books["1John"] = "62"
	books["2John"] = "63"
	books["3John"] = "64"
	books["Jude"] = "65"
	books["Rev"] = "66"

	local book, chapter, verses = text:match("(%w+)%.?%s*(%d+):(%d+%-%d+)")
	local start_verse, end_verse = verses:match("(%d+)-(%d+)")

	local book_num = books[book]
	local range_start = string.format("%s%03d%03d", book_num, tonumber(chapter), tonumber(start_verse))
	local range_end = string.format("%s%03d%03d", book_num, tonumber(chapter), tonumber(end_verse))

	return range_start .. "-" .. range_end
end

local function show_verse_tooltip(verses, _)
	local content = verses[1].content:gsub("<[^>]+>", ""):gsub("&nbsp;", " "):gsub("&amp;", "&"):gsub("\r", "")
	local title = verses[1].abbreviatedCitation:gsub("&nbsp;", " ")

	local buf = vim.api.nvim_create_buf(false, true)
	local lines = vim.split(content, "\n")

	-- Calculate window size based on content
	local width = 0
	for _, line in ipairs(lines) do
		width = math.max(width, #line)
	end

	local opts = {
		height = math.min(#lines, 20), -- Limit the height to prevent overflow
		width = math.min(width, 80),
		focusable = true,
		border = "rounded",
		relative = "cursor",
		style = "minimal",
		title = title,
		title_pos = "left",
		row = 1,
		col = 1,
	}

	-- Adjust lines by splitting at spaces instead of in the middle of words
	local wrapped_lines = {}
	for _, line in ipairs(lines) do
		local words = vim.split(line, " ")
		local current_line = ""

		for _, word in ipairs(words) do
			if #current_line + #word + 1 > 80 then
				table.insert(wrapped_lines, current_line)
				current_line = word
			else
				if current_line ~= "" then
					current_line = current_line .. " " .. word
				else
					current_line = word
				end
			end
		end

		if #current_line > 0 then
			table.insert(wrapped_lines, current_line)
		end
	end

	opts.height = math.min(#wrapped_lines, 20) -- Limit the height to prevent overflow

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, wrapped_lines)
	local win = vim.api.nvim_open_win(buf, false, opts)

	-- Auto-close on cursor move
	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		callback = function()
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_close(win, true)
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end,
		once = true,
	})
end

function M.fetch_scripture()
	local pos = vim.api.nvim_win_get_cursor(0)
	local line = vim.api.nvim_get_current_line()
	local ref_id = get_reference_id(line)

	local url = string.format("https://www.jw.org/es/biblioteca/biblia/biblia-estudio/libros/json/data/%s", ref_id)

	vim.fn.jobstart({ "curl", "-s", url }, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			local json = vim.fn.json_decode(table.concat(data, "\n"))
			local verses = json.ranges[ref_id].verses
			show_verse_tooltip(verses, pos)
		end,
	})
end

vim.api.nvim_create_user_command("FetchScripture", M.fetch_scripture, {})

return M
