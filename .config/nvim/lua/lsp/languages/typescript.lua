local lspconfig = require "lspconfig"
local ts_utils = require "nvim-lsp-ts-utils"

local M = {}

-- formatting
-- enable_formatting = false,
-- formatter = "prettier",
-- formatter_opts = {},

local opts = { silent = true }
ts_utils.setup {
	debug = false,
	enable_import_on_completion = true,

	-- eslint
	eslint_enable_code_actions = true,
	eslint_bin = "eslint_d",
	eslint_enable_diagnostics = true,
	-- update imports on file move
	update_imports_on_move = true,

	-- no default maps, so you may want to define some here
	--vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
	--vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
	--vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
}

function M.setup(on_attach)
	lspconfig.typescript.setup {
		on_attach = function(client, bufnr)
			on_attach(client)

			ts_utils.setup(ts_utils_settings)
			ts_utils.setup_client(client)
		end,
		--filetypes = O.lang.typescript.filetypes,
	}
end

return M
