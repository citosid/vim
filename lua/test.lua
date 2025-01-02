local M = {}

local books = {
	Gen = "1",
	Exod = "2",
	Lev = "3",
	Num = "4",
	Deut = "5",
	Josh = "6",
	Judg = "7",
	Ruth = "8",
	["1Sam"] = "9",
	["2Sam"] = "10",
	["1Kgs"] = "11",
	["2Kgs"] = "12",
	["1Chr"] = "13",
	["2Chr"] = "14",
	Ezra = "15",
	Neh = "16",
	Esth = "17",
	Job = "18",
	Ps = "19",
	Prov = "20",
	Eccl = "21",
	Song = "22",
	Isa = "23",
	Jer = "24",
	Lam = "25",
	Ezek = "26",
	Dan = "27",
	Hos = "28",
	Joel = "29",
	Amos = "30",
	Obad = "31",
	Jonah = "32",
	Mic = "33",
	Nah = "34",
	Hab = "35",
	Zeph = "36",
	Hag = "37",
	Zech = "38",
	Mal = "39",
	Matt = "40",
	Mark = "41",
	Luke = "42",
	John = "43",
	Acts = "44",
	Rom = "45",
	["1Cor"] = "46",
	["2Cor"] = "47",
	Gal = "48",
	Eph = "49",
	Phil = "50",
	Col = "51",
	["1Thess"] = "52",
	["2Thess"] = "53",
	["1Tim"] = "54",
	["2Tim"] = "55",
	Titus = "56",
	Phlm = "57",
	Heb = "58",
	Jas = "59",
	["1Pet"] = "60",
	["2Pet"] = "61",
	["1John"] = "62",
	["2John"] = "63",
	["3John"] = "64",
	Jude = "65",
	Rev = "66",
}

-- Convert bible reference to numerical ID
local function get_reference_id(line, cursor_pos)
	-- Find all the scripture references in the current line
	local scriptures = {}
	for book, chapter, start_verse, end_verse in line:gmatch("(%w+)%s*(%d+):(%d+)%s*%-?%s*(%d*)") do
		table.insert(scriptures, {
			book = book,
			chapter = tonumber(chapter),
			start_verse = tonumber(start_verse),
			end_verse = tonumber(end_verse) or tonumber(start_verse),
			start_pos = line:find(book .. "%s*" .. chapter .. ":" .. start_verse),
		})
	end

	-- Find the scripture closest to the cursor position
	local nearest_scripture = nil
	local min_distance = math.huge
	for _, scripture in ipairs(scriptures) do
		local distance = math.abs(cursor_pos - scripture.start_pos)
		if distance < min_distance then
			nearest_scripture = scripture
			min_distance = distance
		end
	end

	if not nearest_scripture then
		return vim.notify("No valid scripture reference found")
	end

	local book_num = books[nearest_scripture.book]
	if not book_num then
		return vim.notify("Invalid book")
	end

	local range_start = string.format("%s%03d%03d", book_num, nearest_scripture.chapter, nearest_scripture.start_verse)
	local range_end = string.format("%s%03d%03d", book_num, nearest_scripture.chapter, nearest_scripture.end_verse)

	return nearest_scripture.start_verse == nearest_scripture.end_verse and range_start
		or range_start .. "-" .. range_end
end

local function show_verse_tooltip(ref_id, json)
	local content = ""
	local title = json.ranges[ref_id].citation:gsub("&nbsp;", " ")

	for _, verse in ipairs(json.ranges[ref_id].verses) do
		content = content
			.. verse.content:gsub("<[^>]+>", ""):gsub("&nbsp;", " "):gsub("&amp;", "&"):gsub("\r", "")
			.. "\n"
	end

	local buf = vim.api.nvim_create_buf(false, true)
	local lines = vim.split(content, "\n")

	-- Adjust lines by splitting at spaces instead of in the middle of words
	local wrapped_lines = {}
	for _, line in ipairs(lines) do
		local words = vim.split(line, " ")
		local current_line = ""

		for _, word in ipairs(words) do
			if #current_line + #word + 1 > 60 then
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

	local height = math.min(#wrapped_lines, 20)

	-- Calculate window size based on content
	local width = 0
	for _, line in ipairs(wrapped_lines) do
		width = math.max(width, #line)
	end

	local opts = {
		relative = "cursor",
		width = width,
		height = height,
		row = 1,
		col = 0,
		border = "rounded",
		title = title,
		title_pos = "center",
	}

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, wrapped_lines)
	local win = vim.api.nvim_open_win(buf, false, opts)

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
	local cursor_pos = vim.api.nvim_win_get_cursor(0)[2] + 1
	local line = vim.api.nvim_get_current_line()

	local ref_id = get_reference_id(line, cursor_pos)

	if not ref_id then
		print("No valid scripture reference found")
		return
	end

	local url = string.format("https://www.jw.org/es/biblioteca/biblia/biblia-estudio/libros/json/data/%s", ref_id)

	vim.notify(url)

	vim.fn.jobstart({ "curl", "-s", url }, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			local json = vim.fn.json_decode(table.concat(data, "\n"))
			if json.ranges == nil then
				print("Scripture not found")
				return
			end

			show_verse_tooltip(ref_id, json)
		end,
	})
end

vim.api.nvim_create_user_command("FetchScripture", M.fetch_scripture, {})

return M
