local ensure_installed = {
	"tsserver",
	"eslint",
	"html",
	"cssls",
	"rust_analyzer",
	"bashls",
	"dockerls", -- dockerls
	"docker_compose_language_service", -- docker-compose ls
	"jsonls",
	"intelephense", -- php
	"lua_ls",
	"marksman",
	"jedi_language_server", -- python
	"r_language_server",
	"sqlls",
	"lemminx", -- xml
	"yamlls", -- yaml
}

local function cmp_setup()
	local cmp = require("cmp")
	require("copilot").setup({
		suggestion = { enabled = false },
		panel = { enabled = false },
	})
	require("copilot_cmp").setup()
	cmp.setup({
		sources = {
			{ name = "copilot" },
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "nvim_lua" },
		},
		mapping = {
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			}),
		},
	})
end

local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v3.x",
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" }, -- Required
		{ "williamboman/mason.nvim" }, -- Optional
		{ "williamboman/mason-lspconfig.nvim" }, -- Optional
		{ "lukas-reineke/lsp-format.nvim" },

		-- Autocompletion
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				{
					"zbirenbaum/copilot.lua",
					"zbirenbaum/copilot-cmp",
					"hrsh7th/cmp-path",
					"hrsh7th/cmp-nvim-lua",
				},
			}, -- Required
		}, -- Required
		{ "hrsh7th/cmp-nvim-lsp" }, -- Required
		{ "L3MON4D3/LuaSnip" },
	},
	config = function()
		print("lsp lua")
		-- local lsp = require("lsp-zero").preset({})
		local lsp_zero = require("lsp-zero")
		local map = require("utils").map

		lsp_zero.on_attach(function(client, bufnr)
			-- local opts = { buffer = bufnr }
			lsp_zero.default_keymaps({ buffer = bufnr })

			map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
			map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
			map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
			map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
			map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
			map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
			map("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })

			map("n", "gd", function()
				require("telescope.builtin").lsp_definitions({ reuse_win = true })
			end, { desc = "Goto Definition" })
			map("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
			map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
			map("n", "gI", function()
				require("telescope.builtin").lsp_implementations({ reuse_win = true })
			end, { desc = "Goto Implementation" })
			map("n", "gy", function()
				require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
			end, { desc = "Goto T[y]pe Definition" })
			map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
			map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
			map("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" }) -- TODO test
			map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
			map("n", "<leader>cA", function()
				vim.lsp.buf.code_action({
					context = {
						only = {
							"source",
						},
						diagnostics = {},
					},
				})
			end, { desc = "Source Action" })

			-- Format on save
			--   if client.supports_method('textDocument/formatting') then
			--     require('lsp-format').on_attach(client)
			--
			--     vim.keymap.set({ 'n', 'x' }, 'gq', function()
			--       vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
			--     end, opts)
			--   end
		end)

		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = ensure_installed,
			handlers = {
				lsp_zero.default_setup,
			},
		})

		local lua_opts = lsp_zero.nvim_lua_ls()
		require("lspconfig").lua_ls.setup(lua_opts)

		-- lsp.ensure_installed(ensure_installed)
		--
		-- cmp_setup()
		--
		-- lsp.setup()
	end,
}
