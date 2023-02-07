return {
	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		-- load cmp on InsertEnter
		event = "InsertEnter",
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local select_opts = { behavior = cmp.SelectBehavior.Select }

			local function next_in_completed(fallback)
				if luasnip.jumpable(1) then
					luasnip.jump(1)
				else
					fallback()
				end
			end

			local function prev_in_completed(fallback)
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end

			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({

					-- navigation
					["<C-j>"] = cmp.mapping.select_next_item(select_opts),
					["<C-k>"] = cmp.mapping.select_prev_item(select_opts),
					["<C-l>"] = cmp.mapping(next_in_completed, { "i", "s" }),
					["<C-h>"] = cmp.mapping(prev_in_completed, { "i", "s" }),

					-- documenation
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				--formatting = {
				--	format = function(_, item)
				--		local icons = require("lazyvim.config").icons.kinds
				--		if icons[item.kind] then
				--			item.kind = icons[item.kind] .. item.kind
				--		end
				--		return item
				--	end,
				--},
				experimental = {
					ghost_text = {
						hl_group = "LspCodeLens",
					},
				},
			}
		end,
	},
	-- snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			-- "rafamadriz/friendly-snippets",
		},
		config = function()
			-- require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
		end,
		-- opts = {
		-- 	history = true,
		-- 	delete_check_events = "TextChanged",
		-- },
		build = "make install_jsregexp",
		-- keys = {
		-- 	{
		-- 		"<tab>",
		-- 		function()
		-- 			return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
		-- 		end,
		-- 		expr = true,
		-- 		silent = true,
		-- 		mode = "i",
		-- 	},
		-- 	{
		-- 		"<tab>",
		-- 		function()
		-- 			require("luasnip").jump(1)
		-- 		end,
		-- 		mode = "s",
		-- 	},
		-- 	{
		-- 		"<s-tab>",
		-- 		function()
		-- 			require("luasnip").jump(-1)
		-- 		end,
		-- 		mode = { "i", "s" },
		-- 	},
		-- },
	},
}
