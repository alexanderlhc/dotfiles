require("plugins.lsp.languages.json")
return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		-- event = "BufReadPre",
		dependencies = {
			{
				"folke/neodev.nvim",
				opts = { experimental = { pathStrict = true } },
				library = { plugins = { "neotest" }, types = true },
			},
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{
				"hrsh7th/cmp-nvim-lsp",
				cond = function()
					return require("utils").has("nvim-cmp")
				end,
			},
			{ "jose-elias-alvarez/typescript.nvim" },
			{
				"b0o/SchemaStore.nvim",
				version = false, -- last release is way too old
			},
		},
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, prefix = "●" },
				severity_sort = true,
			},
			autoformat = true,
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
			servers = {
				jsonls = require("plugins.lsp.languages.json"),
				-- sumneko_lua = {
				lua_ls = {
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},
				vimls = {},
				pyright = {},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							cargo = { allFeatures = true },
							checkOnSave = {
								command = "clippy",
								extraArgs = { "--no-deps" },
							},
						},
					},
				},
				yamlls = {},
				cssls = {},
				dockerls = {},
				tsserver = {},
				svelte = {},
				eslint = {},
				html = {},
				bashls = {},
			},
			-- return true if you don't want this server to be setup with lspconfig
			setup = { -- per server setup
				tsserver = function(_, opts)
					require("plugins.lsp.languages.typescript").setup(opts)
					return true
				end,
				--jsonls = function(_, opts)
				--  require("plugins.lsp.languages.json")
				--  return false
				--end
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
		config = function(plugin, opts)
			require("plugins.lsp.format").autoformat = opts.autoformat

			require("utils").on_attach(function(client, buffer)
				require("plugins.lsp.format").on_attach(client, buffer)
				require("plugins.lsp.keymaps").on_attach(client, buffer)
			end)

			-- diagnostics
			--for name, icon in pairs(require("lazyvim.config").icons.diagnostics) do
			--  name = "DiagnosticSign" .. name
			--  vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			--end
			vim.diagnostic.config(opts.diagnostics)

			local servers = opts.servers
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			local function setup(server)
				local server_opts = servers[server] or {}
				server_opts.capabilities = capabilities
				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			local mlsp = require("mason-lspconfig")
			local available = mlsp.get_available_servers()

			local ensure_installed = {} ---@type string[]
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
					if server_opts.mason == false or not vim.tbl_contains(available, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup_handlers({ setup })
		end,
	},

	-- formatters
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		dependencies = { "mason.nvim" },
		opts = function()
			local nls = require("null-ls")
			return {
				sources = {
					-- nls.builtins.diagnostics.flake8,
					-- nls.code_actions.eslint_d,
					nls.builtins.code_actions.gitsigns,
					-- nls.code_actions.refactoring,
					-- nls.code_actions.shellcheck,
					-- nls.diagnostics.eslint_d,
					-- nls.diagnostics.tsc,
					-- nls.diagnostics.zsh,
					nls.builtins.formatting.fixjson,
					nls.builtins.formatting.prettierd,
					nls.builtins.formatting.shellharden,
					nls.builtins.formatting.shfmt,
					nls.builtins.formatting.stylua,
				},
			}
		end,
	},

	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = {
			ensure_installed = {
				"stylua",
				"shellcheck",
				"shfmt",
				"flake8",
			},
		},
	},
}
