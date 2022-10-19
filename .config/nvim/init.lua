local util = require("util")

util.require("options")

--[[ require("options") ]]
--require("functions")
--require("keymaps")
--require("plugins")
---- require('plugin-configs.lsp')
--require("plugin-configs.mason")

vim.schedule(function()
	util.packer_defered()
	util.version()
	util.require("keymaps")
	util.require("plugins")
end)
