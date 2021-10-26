local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- -- compe config
-- require("compe").setup({
-- 	enabled = true,
-- 	autocomplete = true,
-- 	debug = false,
-- 	min_length = 1,
-- 	preselect = "enable",
-- 	throttle_time = 80,
-- 	source_timeout = 200,
-- 	resolve_timeout = 800,
-- 	incomplete_delay = 400,
-- 	max_abbr_width = 100,
-- 	max_kind_width = 100,
-- 	max_menu_width = 100,
-- 	documentation = {
-- 		border = { "", "", "", " ", "", "", "", " " }, -- the border option is the same as `|help nvim_open_win|`
-- 		winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
-- 		max_width = 120,
-- 		min_width = 60,
-- 		max_height = math.floor(vim.o.lines * 0.3),
-- 		min_height = 1,
-- 	},

-- 	source = {
-- 		path = true,
-- 		buffer = true,
-- 		calc = true,
-- 		nvim_lsp = true,
-- 		nvim_lua = true,
-- 		vsnip = true,
-- 		ultisnips = true,
-- 		luasnip = true,
-- 	},
-- })
  -- local cmp = require'cmp'

  -- cmp.setup({
  --   snippet = {
  --     expand = function(args)
  --       --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
  --       require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
  --       -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  --       -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
  --     end,
  --   },
  --   mapping = {
  --     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
  --     ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --     ['<C-Space>'] = cmp.mapping.complete(),
  --     ['<C-e>'] = cmp.mapping.close(),
  --     ['<CR>'] = cmp.mapping.confirm({ select = true }),
  --   },
  --   sources = cmp.config.sources({
  --     { name = 'nvim_lsp' },
  --     --{ name = 'vsnip' }, -- For vsnip users.
  --     { name = 'luasnip' }, -- For luasnip users.
  --     -- { name = 'ultisnips' }, -- For ultisnips users.
  --     -- { name = 'snippy' }, -- For snippy users.
  --   }, {
  --     { name = 'buffer' },
  --   })
  -- })

  -- -- Setup lspconfig.
  -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- require('lspconfig')[%YOUR_LSP_SERVER%].setup {
  --   capabilities = capabilities
-- }
