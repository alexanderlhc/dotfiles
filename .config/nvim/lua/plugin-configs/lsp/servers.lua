local servers = {
	bashls = {},
	cssls = {},
	dockerls = {},
	tsserver = {},
	eslint = {},
	html = {},
	jsonls = {
		settings = {
			json = {
				format = {
					enable = true,
				},
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	},
	yamlls = {},
	sumneko_lua = {
		cmd = { "/usr/lib/lua-language-server/bin/lua-language-server" },
		single_file_support = true,
		settings = {
			Lua = {
				workspace = {
					checkThirdParty = false,
				},
				completion = {
					workspaceWord = true,
				},
				misc = {
					parameters = {
						"--log-level=trace",
					},
				},
				diagnostics = {
					-- enable = false,
					groupFileStatus = {
						["ambiguity"] = "Opened",
						["await"] = "Opened",
						["codestyle"] = "None",
						["duplicate"] = "Opened",
						["global"] = "Opened",
						["luadoc"] = "Opened",
						["redefined"] = "Opened",
						["strict"] = "Opened",
						["strong"] = "Opened",
						["type-check"] = "Opened",
						["unbalanced"] = "Opened",
						["unused"] = "Opened",
					},
					unusedLocalExclude = { "_*" },
				},
				format = {},
			},
		},
	},
	vimls = {},
}

return servers
