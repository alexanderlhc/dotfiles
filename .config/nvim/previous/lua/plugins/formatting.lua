local formatter_data = {
	prettierd = {
		".prettierrc",
		".prettierrc.json",
		".prettierrc.yml",
		".prettierrc.yaml",
		".prettierrc.json5",
		".prettierrc.js",
		".prettierrc.cjs",
		".prettierrc.mjs",
		".prettierrc.toml",
		"prettier.config.js",
		"prettier.config.cjs",
		"prettier.config.mjs",
	},
	eslint_d = {
		".eslintrc",
		".eslintrc.js",
		".eslintrc.json",
		"eslint.config.mjs",
	},
}

-- Function to find closest configuration file for a given formatter
local function find_closest_config_file(config_names, current_file)
	if not config_names then
		return nil
	end
	for _, config_name in ipairs(config_names) do
		local found = vim.fs.find(config_name, { upward = true, path = vim.fn.fnamemodify(current_file, ":p:h") })
		if #found > 0 then
			return found[1]
		end
	end
	return nil
end

local function define_autoformat_commands()
	vim.api.nvim_create_user_command("FormatDisable", function(args)
		if args.bang then
			vim.b.disable_autoformat = true
		else
			vim.g.disable_autoformat = true
		end
	end, {
		desc = "Disable autoformat-on-save",
		bang = true,
	})

	vim.api.nvim_create_user_command("FormatEnable", function()
		vim.b.disable_autoformat = false
		vim.g.disable_autoformat = false
	end, {
		desc = "Re-enable autoformat-on-save",
	})

	vim.api.nvim_create_user_command("Format", function()
		local conform = require("conform")
		local formatters = conform.list_formatters(0)
		local current_file = vim.api.nvim_buf_get_name(0)

		if #formatters == 0 then
			vim.notify("No formatters available for this buffer, using lsp", vim.log.levels.WARN)
			conform.format({ async = false, lsp_format = "fallback" })
			return
		end

		local formatter_to_use = nil
		for _, formatter in ipairs(formatters) do
			local config_file = find_closest_config_file(formatter_data[formatter.name], current_file)
			if config_file then
				print("using: " .. config_file)
				formatter_to_use = formatter.name
				break
			end
		end

		if not formatter_to_use then
			formatter_to_use = formatters[1].name
		end
		vim.notify("Using formatter: " .. formatter_to_use, vim.log.levels.INFO)
		conform.format({ async = false, lsp_format = "never", formatters = { formatter_to_use } })
	end, {})
end

return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	event = { "BufWritePre" },
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>f=",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		default_format_opts = {
			timeout_ms = 3000,
			async = false,
			quiet = false,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
			fish = { "fish_indent" },
			sh = { "shfmt" },
			javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
			typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters = {
			injected = { options = { ignore_errors = true } },
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)
		define_autoformat_commands()
	end,
}
