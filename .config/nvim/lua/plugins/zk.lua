vim.pack.add({
	"https://github.com/zk-org/zk-nvim",
})

local zk = require("zk")
local commands = require("zk.commands")

zk.setup({
	picker = "fzf",
	lsp = {
		config = {
			name = "zk",
			cmd = { "zk", "lsp" },
			filetypes = { "markdown" },
		},
		auto_attach = {
			enabled = true,
		},
	},
})

local function find_zettel()
	local query = vim.fn.input("Find zettel> ")
	local opts = { sort = { "modified" } }
	if query ~= "" then
		opts.match = { query }
	end

	commands.get("ZkNotes")(opts)
end

vim.keymap.set("n", "<leader>fz", find_zettel, { desc = "Find zettel via zk" })
vim.keymap.set("n", "zo", vim.lsp.buf.definition, { desc = "Jump to note under cursor" })
vim.api.nvim_create_user_command("ZkFzf", find_zettel, {
	desc = "Find zettel through zk's FZF picker",
})

vim.api.nvim_set_keymap(
	"n",
	"<leader>zn",
	"<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>",
	{ noremap = true, silent = false, desc = "Create zk note with title" }
)
