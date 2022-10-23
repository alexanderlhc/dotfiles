local servers = {}

servers.html = {}
servers.sumneko_lua = {}
servers.tsserver = {}
servers.vimls = {}
servers.dockerls = {}
servers.bashls = {}

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
