local mason_lsp_config_opts = {
	ensure_installed = {
		"bashls",
		"lua_ls"
	}
}

return 	{
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	keys = {
		{ "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
		{ "gd", vim.lsp.buf.definition, desc = "Goto Definition",
			-- has = "definition" 
		},
		{ "gr", vim.lsp.buf.references, desc = "References", nowait = true },
		{ "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
		{ "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
		{ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
		{ "K", vim.lsp.buf.hover, desc = "Hover" },
		{ "gK", vim.lsp.buf.signature_help, desc = "Signature Help",
			-- has = "signatureHelp" 
		},
		{ "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help",
			-- has = "signatureHelp" 
		},
		{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" },
			--	has = "codeAction" 
		},
		{ "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" },
			-- has = "codeLens" 
		},
		{ "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" },
			-- has = "codeLens" 
		},
		-- { "<leader>cR", LazyVim.lsp.rename_file, desc = "Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
		{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename", 
			--	has = "rename" 
		},
		-- { "<leader>cA", LazyVim.lsp.action.source, desc = "Source Action", has = "codeAction" },
		-- { "]]", function() LazyVim.lsp.words.jump(vim.v.count1) end, has = "documentHighlight",
		-- 	desc = "Next Reference", cond = function() return LazyVim.lsp.words.enabled end },
		-- { "[[", function() LazyVim.lsp.words.jump(-vim.v.count1) end, has = "documentHighlight",
		-- 	desc = "Prev Reference", cond = function() return LazyVim.lsp.words.enabled end },
		-- { "<a-n>", function() LazyVim.lsp.words.jump(vim.v.count1, true) end, has = "documentHighlight",
		-- 	desc = "Next Reference", cond = function() return LazyVim.lsp.words.enabled end },
		-- { "<a-p>", function() LazyVim.lsp.words.jump(-vim.v.count1, true) end, has = "documentHighlight",
		-- 	desc = "Prev Reference", cond = function() return LazyVim.lsp.words.enabled end },
	},
	opts = {
		-- Enable lsp cursor word highlighting
		document_highlight = {
			enabled = true,
		},
		-- handled by another formatter
		format = {
			formatting_options = nil,
			timeout_ms = nil,
		},
		servers = {
			taplo = {
				keys = {
					{
						"K",
						function()
							if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
								require("crates").show_popup()
							else
								vim.lsp.buf.hover()
							end
						end,
						desc = "Show Crate Documentation",
					},
				},
			},
		},
	},
	config = function (_, opts)
		require("mason").setup()
		require("mason-lspconfig").setup(mason_lsp_config_opts)

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup(opts)
			end,
		})
	end,
}
