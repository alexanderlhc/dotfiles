        https://github.com/folke/lazy.nvim
		-- Lua
		use({
			"folke/twilight.nvim",
			config = function()
				require("twilight").setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
		})

		-- Reduces distractions writing code
		use({
			"folke/zen-mode.nvim",
			config = function()
				require("zen-mode").setup({})
			end,
			wants = { "folke/twilight.nvim" },
		})


        		use({
			"danymat/neogen",
			config = function()
				require("plugins.neogen").setup()
			end,
			requires = "nvim-treesitter/nvim-treesitter",
		})


        		-- Comments
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})
