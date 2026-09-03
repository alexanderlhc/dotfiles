vim.pack.add({ "https://github.com/nvim-mini/mini.ai" })

local ai = require("mini.ai")

ai.setup({
	custom_textobjects = {
		-- `af`/`if` belong to the treesitter function *definition* (see
		-- plugins/treesitter.lua); mini.ai's function *call* moves to `aF`/`iF`.
		F = ai.gen_spec.function_call(),
		f = false,
	},
})
