local merge = require("util.merge")

local M = {}

function M.warn(msg, name)
	vim.notify(msg, vim.log.levels.WARN, { title = name or "init.lua" })
end

function M.error(msg, name)
	vim.notify(msg, vim.log.levels.ERROR, { title = name or "init.lua" })
end

function M.info(msg, name)
	vim.notify(msg, vim.log.levels.INFO, { title = name or "init.lua" })
end

function M.require(mod)
	return M.try(require, mod)
end

function M.try(fn, ...)
	local args = { ... }

	return xpcall(function()
		return fn(unpack(args))
	end, function(err)
		local lines = {}
		table.insert(lines, err)
		table.insert(lines, debug.traceback("", 3))

		M.error(table.concat(lines, "\n"))
		return err
	end)
end

function M.packer_defered()
	vim.cmd([[do User PackerDefered]])
	-- vim.api.nvim_exec_autocmds("User", { pattern = "PackerDefered" })
end

function M.version()
	local v = vim.version()
	if not v.prerelease then
		vim.notify(
			("Neovim v%d.%d.%d"):format(v.major, v.minor, v.patch),
			vim.log.levels.WARN,
			{ title = "Neovim: not running nightly!" }
		)
	end
end

-----

-- TODO: migrate https://neovim.io/doc/user/lua.html#vim.keymap.set()
function M.map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return M
