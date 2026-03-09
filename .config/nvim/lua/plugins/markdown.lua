vim.pack.add({
	"https://github.com/tadmccorkle/markdown.nvim",
})

local function normalize_range(start_pos, end_pos)
	local start_line, start_col = start_pos[2], start_pos[3]
	local end_line, end_col = end_pos[2], end_pos[3]
	if start_line > end_line or (start_line == end_line and start_col > end_col) then
		return end_line, end_col, start_line, start_col
	end
	return start_line, start_col, end_line, end_col
end

local function toggle_wrapper(bufnr, prefix, suffix)
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local start_line, start_col, end_line, end_col = normalize_range(start_pos, end_pos)
	local lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
	if #lines == 0 then
		return
	end

	local first = lines[1]
	local last = lines[#lines]
	local has_prefix = first:sub(start_col, start_col + #prefix - 1) == prefix
	local has_suffix = last:sub(end_col - #suffix + 1, end_col) == suffix

	if has_prefix and has_suffix then
		if start_line == end_line then
			local line = first
			line = line:sub(1, end_col - #suffix) .. line:sub(end_col + 1)
			line = line:sub(1, start_col - 1) .. line:sub(start_col + #prefix)
			lines[1] = line
		else
			first = first:sub(1, start_col - 1) .. first:sub(start_col + #prefix)
			last = last:sub(1, end_col - #suffix) .. last:sub(end_col + 1)
			lines[1] = first
			lines[#lines] = last
		end
	else
		if start_line == end_line then
			local line = first
			line = line:sub(1, start_col - 1) .. prefix .. line:sub(start_col)
			local end_col_adjusted = end_col + #prefix
			line = line:sub(1, end_col_adjusted) .. suffix .. line:sub(end_col_adjusted + 1)
			lines[1] = line
		else
			first = first:sub(1, start_col - 1) .. prefix .. first:sub(start_col)
			last = last:sub(1, end_col) .. suffix .. last:sub(end_col + 1)
			lines[1] = first
			lines[#lines] = last
		end
	end

	vim.api.nvim_buf_set_lines(bufnr, start_line - 1, end_line, false, lines)
end

local function collect_markdown_headers(bufnr)
	local headers = {}
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	for idx, line in ipairs(lines) do
		local prefix, content = line:match("^%s*(#+)%s*(.-)%s*$")
		if prefix and content ~= "" then
			content = content:gsub("%s*#*%s*$", "")
			content = content:gsub("%s*$", "")
			if content ~= "" then
				headers[#headers + 1] = {
					line = idx,
					prefix = prefix,
					level = #prefix,
					text = content,
				}
			end
		end
	end
	return headers
end

local function open_markdown_headers_with_fzf(bufnr)
	local ok, fzf = pcall(require, "fzf-lua")
	if not ok then
		vim.notify("fzf-lua is required for Markdown header navigation", vim.log.levels.WARN)
		return
	end

	local headers = collect_markdown_headers(bufnr)
	if vim.tbl_isempty(headers) then
		vim.notify("No Markdown headers in buffer", vim.log.levels.INFO)
		return
	end

	local entries = {}
	for _, header in ipairs(headers) do
		entries[#entries + 1] = string.format("%04d │ %s %s", header.line, header.prefix, header.text)
	end

	fzf.fzf_exec(entries, {
		prompt = "Headers> ",
		winopts = { height = 0.25 },
		actions = {
			["default"] = function(selected)
				local selection = selected[1]
				if not selection then
					return
				end
				local target_line = tonumber(selection:match("^(%d+)"))
				if target_line then
					vim.api.nvim_win_set_cursor(0, { target_line, 0 })
				end
			end,
		},
	})
end

require("markdown").setup({
	on_attach = function(bufnr)
		if vim.bo[bufnr].ft ~= "markdown" then
			return
		end

		local map = vim.keymap.set
		local opts = { buffer = bufnr }
		map("n", "<M-c>", "<Cmd>MDTaskToggle<CR>", opts)
		map("x", "<M-c>", ":MDTaskToggle<CR>", opts)
		map("x", "<leader>mb", function()
			toggle_wrapper(bufnr, "**", "**")
		end, opts)
		map("x", "<leader>mi", function()
			toggle_wrapper(bufnr, "*", "*")
		end, opts)
		map("x", "<leader>ms", function()
			toggle_wrapper(bufnr, "~~", "~~")
		end, opts)
		map("x", "<leader>mc", function()
			toggle_wrapper(bufnr, "`", "`")
		end, opts)
		map("x", "zn", ":'<,'>ZkNewFromTitleSelection<CR>", opts)
		map("n", "<leader>fh", function()
			open_markdown_headers_with_fzf(bufnr)
		end, vim.tbl_extend("force", opts, { desc = "Open Markdown headers with fzf" }))
		map("x", "<leader>mu", function()
			toggle_wrapper(bufnr, "<u>", "</u>")
		end, opts)
	end,
})
