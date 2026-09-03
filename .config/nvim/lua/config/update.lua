-- `:PackUpdate` updates everything that is version-pinned outside the config:
-- vim.pack plugins (via the lockfile), tree-sitter parsers and Mason packages.

local function notify(msg, level)
	vim.notify(msg, level or vim.log.levels.INFO, { title = "PackUpdate" })
end

local function update_parsers()
	local ok, ts = pcall(require, "nvim-treesitter")
	if not ok then
		return
	end
	notify("updating tree-sitter parsers")
	ts.update(nil, { summary = true })
end

local function update_mason()
	local ok, registry = pcall(require, "mason-registry")
	if not ok then
		return
	end
	registry.refresh(function()
		local outdated = {}
		for _, pkg in ipairs(registry.get_installed_packages()) do
			if pkg:get_installed_version() ~= pkg:get_latest_version() then
				table.insert(outdated, pkg)
			end
		end
		if #outdated == 0 then
			notify("mason: all packages current")
			return
		end
		notify(("mason: updating %d package(s)"):format(#outdated))
		for _, pkg in ipairs(outdated) do
			pkg:install(nil, function(success, err)
				if success then
					notify("mason: updated " .. pkg.name)
				else
					notify(("mason: %s failed: %s"):format(pkg.name, tostring(err)), vim.log.levels.ERROR)
				end
			end)
		end
	end)
end

vim.api.nvim_create_user_command("PackUpdate", function()
	-- Opens the confirmation buffer; writing it applies the updates.
	vim.pack.update()
	vim.cmd.write()
	update_parsers()
	update_mason()
end, { desc = "Update plugins, tree-sitter parsers and Mason packages" })
