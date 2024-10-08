local function on_attach(attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("eden_lsp_attach", { clear = true }),
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			attach(client, buffer)
		end,
	})
end

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason.nvim",
				config = true,
				dependencies = { "williamboman/mason-lspconfig.nvim" },
			},
			{
				"hrsh7th/nvim-cmp",
				dependencies = {
					"hrsh7th/cmp-nvim-lsp",
					"zbirenbaum/copilot.lua",
					"zbirenbaum/copilot-cmp",
					"hrsh7th/cmp-path",
					"hrsh7th/cmp-nvim-lua",
					"hrsh7th/cmp-cmdline",
					"L3MON4D3/LuaSnip",
					"saadparwaiz1/cmp_luasnip",
					{
						"Saecki/crates.nvim",
						event = { "BufRead Cargo.toml" },
						opts = {
							completion = {
								cmp = { enabled = true },
							},
						},
					},
				},
				config = function()
					local cmp = require("cmp")
					local cmp_select = { behavior = cmp.SelectBehavior.Select }
					require("copilot_cmp").setup()
					cmp.setup({
						sources = {
							{ name = "copilot" },
							{ name = "crates" },
							{ name = "path" },
							{ name = "nvim_lsp" },
							{ name = "luasnip" },
							{ name = "buffer" },
							{ name = "nvim_lua" },
							{
								{
									name = "cmdline",
									option = {
										ignore_cmds = { "Man", "!" },
									},
								},
							},
						},
						mapping = cmp.mapping.preset.insert({
							-- scrolling
							["<C-b>"] = cmp.mapping.scroll_docs(-4),
							["<C-f>"] = cmp.mapping.scroll_docs(4),
							-- select
							["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
							["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
							-- confirm
							["<C-y>"] = cmp.mapping.confirm({ select = true }),
							["<C-Space>"] = cmp.mapping.complete(),
							--
						}),
						experimental = {
							ghost_text = true,
						},
						snippet = {
							expand = function(args)
								require("luasnip").lsp_expand(args.body)
							end,
						},
					})
				end,
			},
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
				build = "make install_jsregexp",
				event = "InsertEnter",
				config = function()
					local snip_path = vim.fn.stdpath("config") .. "/lua/snippets"
					require("luasnip.loaders.from_lua").load({ paths = snip_path })
				end,
				opts = {
					history = true,
					delete_check_events = "TextChanged",
				},
				keys = {
					{
						"<C-l>",
						function()
							local luasnip = require("luasnip")
							if luasnip.jumpable(1) then
								luasnip.jump(1)
							end
						end,
						mode = { "i", "s" },
					},

					{
						"<C-h>",
						function()
							local luasnip = require("luasnip")
							if luasnip.jumpable(-1) then
								luasnip.jump(-1)
							end
						end,
						mode = { "i", "s" },
					},
				},
			},
			{
				"zbirenbaum/copilot.lua",
				cmd = "Copilot",
				event = "InsertEnter",
				opts = {
					suggestion = { enabled = true },
					panel = { enabled = false },
				},
			},
		},
		config = function()
			local lspconfig = require("lspconfig")
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"eslint",
					"tsserver",
					"marksman",
					"intelephense",
					"sqlls",
					"yamlls",
					"html",
					"htmx",
					"docker_compose_language_service",
					"dockerls",
					"cssls",
					"bashls",
					"rust_analyzer",
					"taplo",
				},
				automatic_installation = true,
				handlers = {
					function(server)
						lspconfig[server].setup({
							capabilities = require("cmp_nvim_lsp").default_capabilities(),
						})
					end,
					["rust_analyzer"] = function()
						-- replaced with rustaceanvim
					end,
					["tsserver"] = function()
						lspconfig.tsserver.setup({
							settings = {
								typescript = {
									inlayHints = {
										includeInlayParameterNameHints = "all",
										includeInlayParameterNameHintsWhenArgumentMatchesName = false,
										includeInlayFunctionParameterTypeHints = true,
										includeInlayVariableTypeHints = true,
										includeInlayVariableTypeHintsWhenTypeMatchesName = false,
										includeInlayPropertyDeclarationTypeHints = true,
										includeInlayFunctionLikeReturnTypeHints = true,
										includeInlayEnumMemberValueHints = true,
									},
								},
								javascript = {
									inlayHints = {
										includeInlayParameterNameHints = "all",
										includeInlayParameterNameHintsWhenArgumentMatchesName = false,
										includeInlayFunctionParameterTypeHints = true,
										includeInlayVariableTypeHints = true,
										includeInlayVariableTypeHintsWhenTypeMatchesName = false,
										includeInlayPropertyDeclarationTypeHints = true,
										includeInlayFunctionLikeReturnTypeHints = true,
										includeInlayEnumMemberValueHints = true,
									},
								},
							},
						})
					end,
				},
			})
			on_attach(function(client, buffer)
				--
			end)
			require("plugins.lsp.keys").set_keymaps()
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		ft = { "rust" },
		opts = {
			server = {
				default_settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
						},
						checkOnSave = true,
					},
				},
			},
		},
		config = function(_, opts)
			vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
			if vim.fn.executable("rust-analyzer") == 0 then
				-- notify an error
				vim.notify("rust-analyzer is not installed", vim.log)
			end
		end,
		dependencies = {
			{
				"Saecki/crates.nvim",
				event = { "BufRead Cargo.toml" },
				opts = {
					completion = {
						cmp = { enabled = true },
					},
				},
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
				{
					"williamboman/mason.nvim",
					optional = true,
					opts = { ensure_installed = { "codelldb" } },
				},
			},
		},
	},
}
