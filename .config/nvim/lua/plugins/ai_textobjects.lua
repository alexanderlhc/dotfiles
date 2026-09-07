vim.pack.add({ "https://github.com/nvim-mini/mini.ai" })

local ai = require("mini.ai")

ai.setup({
	custom_textobjects = {
		-- `af`/`if` belong to the treesitter function *definition* (see
		-- plugins/treesitter.lua); mini.ai's function *call* moves to `aF`/`iF`.
		F = ai.gen_spec.function_call(),
		f = false,

		-- mini.ai owns every `a`/`i` key, which shadows the `al`/`il` builtins
		-- Neovim 0.13 added. Reimplement them: `al` is the whole buffer, `il`
		-- is the current line without surrounding whitespace (and, like the
		-- builtin, fails on a blank line).
		l = function(ai_type)
			if ai_type == "a" then
				local last = vim.fn.line("$")
				return {
					from = { line = 1, col = 1 },
					to = { line = last, col = math.max(vim.fn.getline(last):len(), 1) },
					vis_mode = "V",
				}
			end

			local line = vim.fn.line(".")
			local text = vim.fn.getline(line)
			local first = text:find("%S")
			if first == nil then
				return nil
			end
			local last = #text - text:reverse():find("%S") + 1
			-- The builtin `il` is charwise even though `al` is linewise.
			return { from = { line = line, col = first }, to = { line = line, col = last }, vis_mode = "v" }
		end,
	},
})
