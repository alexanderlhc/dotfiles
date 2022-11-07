local M = {}

function M.setup()
	-- Indicate first time installation
	local packer_bootstrap = false

	-- packer.nvim configuration
	local conf = {
		profile = {
			enable = true,
			threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
		},

		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	}

	-- Check if packer.nvim is installed
	-- Run PackerCompile if there are changes in this file
	local function packer_init()
		local fn = vim.fn
		local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
		if fn.empty(fn.glob(install_path)) > 0 then
			packer_bootstrap = fn.system({
				"git",
				"clone",
				"--depth",
				"1",
				"https://github.com/wbthomason/packer.nvim",
				install_path,
			})
			vim.cmd([[packadd packer.nvim]])
		end

		-- Run PackerCompile if there are changes in this file
		-- vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
		local packer_grp = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
		vim.api.nvim_create_autocmd(
			{ "BufWritePost" },
			{ pattern = "init.lua", command = "source <afile> | PackerCompile", group = packer_grp }
		)
	end

	-- Plugins
	local function plugins(use)
		use({ "wbthomason/packer.nvim" })

		-- Performance
		use({ "lewis6991/impatient.nvim" })

		-- Rice
		use({
			"projekt0n/github-nvim-theme",
			config = function()
				require("plugins.github-theme").setup()
			end,
		})
		use({ "kyazdani42/nvim-web-devicons" })

		-- Mapping
		use({
			"folke/which-key.nvim",
			event = "VimEnter",
			config = function()
				require("plugins.whichkey").setup()
			end,
		})

		-- Tools
		use({
			"nvim-telescope/telescope.nvim",
			requires = { { "nvim-lua/plenary.nvim" } },
		})

		-- Surround
		use({
			"kylechui/nvim-surround",
			event = "BufReadPre",
			config = function()
				require("nvim-surround").setup({})
			end,
		})

		-- Filebrowser
		use({
			"kyazdani42/nvim-tree.lua",
			wants = "nvim-web-devicons",
			--opt = true,
			--cmd = { "NvimTreeToggle", "NvimTreeClose" },
			config = function()
				require("plugins.nvimtree").setup()
			end,
		})

		-- Treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = function()
				require("plugins.treesitter").setup()
			end,
			requires = {},
		})

		-- LSP
		use({
			"neovim/nvim-lspconfig",
			requires = {
				"williamboman/mason.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				"williamboman/mason-lspconfig.nvim",
				"jose-elias-alvarez/null-ls.nvim",
				"jose-elias-alvarez/typescript.nvim",
				{ "b0o/SchemaStore.nvim", module = "schemastore" },
			},
			config = function()
				require("plugins.lsp").setup()
			end,
		})
		-- Languages
		-- LUA
		use({ "folke/neodev.nvim" })

		-- Documentation generation
		use({
			"danymat/neogen",
			config = function()
				require("plugins.neogen").setup()
			end,
			requires = "nvim-treesitter/nvim-treesitter",
		})

		-- Completion
		use({
			"hrsh7th/nvim-cmp",
			--event = "InsertEnter",
			--opt = true,
			config = function()
				require("plugins.cmp").setup()
			end,
			requires = {
				{ "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" },
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-emoji",
				"hrsh7th/cmp-path",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lsp-signature-help",
				{
					"L3MON4D3/LuaSnip",
				},
			},
		})

		-- Autopairs
		use({
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		})

		use({
			"zbirenbaum/copilot.lua",
			--event = "InsertEnter",
			config = function()
				require("copilot").setup()
			end,
		})

		use({
			"zbirenbaum/copilot-cmp",
			after = { "copilot.lua" },
			config = function()
				require("copilot_cmp").setup({
					method = "getCompletionsCycling",
				})
			end,
		})

		-- Comments
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})

		-- Refactoring²
		use({
			"ThePrimeagen/refactoring.nvim",
			module = "refactoring",
			config = function()
				require("refactoring").setup({})
			end,
			setup = function()
				-- prompt for a refactor to apply when the remap is triggered
				vim.keymap.set("v", "<leader>cr", function()
					require("refactoring").select_refactor()
				end, { noremap = true, silent = true, expr = false })
			end,
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-treesitter/nvim-treesitter" },
			},
		})

		-- dap
		use({
			"mfussenegger/nvim-dap",
			requires = {
				{
					"rcarriga/nvim-dap-ui",
					config = function()
						require("dapui").setup()
					end,
				},
				"theHamsta/nvim-dap-virtual-text",
			},
			config = function()
				require("plugins.dap").setup()
			end,
		})

		-- Bootstrap Neovim
		if packer_bootstrap then
			print("Neovim restart is required after installation!")
			require("packer").sync()
		end
	end

	-- Init and start packer
	packer_init()
	local packer = require("packer")

	-- Performance
	pcall(require, "impatient")
	-- pcall(require, "packer_compiled")

	packer.init(conf)
	packer.startup(plugins)
end

return M
