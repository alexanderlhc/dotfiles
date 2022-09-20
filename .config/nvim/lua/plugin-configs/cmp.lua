local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	mapping = {
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- TabCompletion
		-- ["<Tab>"] = function(fallback)
		["<C-j>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		["<C-k>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
		-- Confirm
		["<C-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "copilot" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "spell" },
		{ name = "copilot" },
		{ name = "path" },
		{ name = "buffer" },
	},
	formatting = {
		format = lspkind.cmp_format(),
	},
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
})

-- local lspkind = require "lspkind"
-- lspkind.init()
--
-- cmp.setup {
--   mapping = {
--     ["<C-d>"] = cmp.mapping.scroll_docs(-4),
--     ["<C-f>"] = cmp.mapping.scroll_docs(4),
--     ["<C-e>"] = cmp.mapping.close(),
--     ["<c-y>"] = cmp.mapping(
--       cmp.mapping.confirm {
--         behavior = cmp.ConfirmBehavior.Insert,
--         select = true,
--       },
--       { "i", "c" }
--     ),
--
--     ["<c-space>"] = cmp.mapping {
--       i = cmp.mapping.complete(),
--       c = function(
--         _ --[[fallback]]
--       )
--         if cmp.visible() then
--           if not cmp.confirm { select = true } then
--             return
--           end
--         else
--           cmp.complete()
--         end
--       end,
--     },
--
--     -- ["<tab>"] = false,
--     ["<tab>"] = cmp.config.disable,
--
--     -- ["<tab>"] = cmp.mapping {
--     --   i = cmp.config.disable,
--     --   c = function(fallback)
--     --     fallback()
--     --   end,
--     -- },
--
--     -- Testing
--     ["<c-q>"] = cmp.mapping.confirm {
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = true,
--     },
--
--     -- If you want tab completion :'(
--     --  First you have to just promise to read `:help ins-completion`.
--     --
--     -- ["<Tab>"] = function(fallback)
--     --   if cmp.visible() then
--     --     cmp.select_next_item()
--     --   else
--     --     fallback()
--     --   end
--     -- end,
--     -- ["<S-Tab>"] = function(fallback)
--     --   if cmp.visible() then
--     --     cmp.select_prev_item()
--     --   else
--     --     fallback()
--     --   end
--     -- end,
--   },
--
--   -- Youtube:
--   --    the order of your sources matter (by default). That gives them priority
--   --    you can configure:
--   --        keyword_length
--   --        priority
--   --        max_item_count
--   --        (more?)
--   sources = {
--     { name = "gh_issues" },
--     { name = 'copilot' },
--     -- Youtube: Could enable this only for lua, but nvim_lua handles that already.
--     { name = "nvim_lua" },
--
--     { name = "nvim_lsp" },
--     { name = "path" },
--     { name = "luasnip" },
--     { name = "buffer", keyword_length = 5 },
--   },
--
--   snippet = {
--     expand = function(args)
--       require("luasnip").lsp_expand(args.body)
--     end,
--   },
--
--   formatting = {
--     -- Youtube: How to set up nice formatting for your sources.
--     format = lspkind.cmp_format {
--       with_text = true,
--       menu = {
--         buffer = "[buf]",
--         copilot = "[copilot]",
--         nvim_lsp = "[LSP]",
--         nvim_lua = "[api]",
--         path = "[path]",
--         luasnip = "[snip]",
--         gh_issues = "[issues]",
--         tn = "[TabNine]",
--       },
--     },
--   },
--
--     experimental = {
--     -- I like the new menu better! Nice work hrsh7th
--     native_menu = false,
--
--     -- Let's play with this for a day or two
--     ghost_text = true,
--   },
-- }
