local servers = {}

servers.html = {}
servers.sumneko_lua = {
	Lua = {
		workspace = { checkThirdParty = false },
		telemetry = { enable = false },
	},
}
servers.tsserver = {}
servers.vimls = {}
servers.dockerls = {}
servers.bashls = {}
servers.rust_analyzer = {}

servers.jsonls = {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
		},
	},
}

servers.yamlls = {
	schemastore = {
		enable = true,
	},
	settings = {
		yaml = {
			hover = true,
			completion = true,
			validate = true,
			schemas = require("schemastore").json.schemas(),
		},
	},
}

return servers
