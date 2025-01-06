return {
	"nvim-neotest/neotest",
	dependencies = { "nvim-neotest/nvim-nio" },
	opts = {
		adapters = {},
		-- Example for loading neotest-golang with a custom config
		-- adapters = {
		--   ["neotest-golang"] = {
		--     go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
		--     dap_go_enabled = true,
		--   },
		-- },
		status = { virtual_text = true },
		output = { open_on_run = true },
	},
	config = function(_, opts)
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					-- Replace newline and tab characters with space for more compact diagnostics
					local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)

		if opts.adapters then
			local adapters = {}
			for name, config in pairs(opts.adapters or {}) do
				if type(name) == "number" then
					if type(config) == "string" then
						config = require(config)
					end
					adapters[#adapters + 1] = config
				elseif config ~= false then
					local adapter = require(name)
					if type(config) == "table" and not vim.tbl_isempty(config) then
						local meta = getmetatable(adapter)
						if adapter.setup then
							adapter.setup(config)
						elseif adapter.adapter then
							adapter.adapter(config)
							adapter = adapter.adapter
						elseif meta and meta.__call then
							adapter = adapter(config)
						else
							error("Adapter " .. name .. " does not support setup")
						end
					end
					adapters[#adapters + 1] = adapter
				end
			end
			opts.adapters = adapters
		end

		require("neotest").setup(opts)
	end,
  -- stylua: ignore
  keys = {
    {"<leader>T", "", desc = "Tests"},
    { "<leader>Tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
    { "<leader>TT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files" },
    { "<leader>Tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
    { "<leader>Tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
    { "<leader>Ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
    { "<leader>To", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
    { "<leader>TO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
    { "<leader>TS", function() require("neotest").run.stop() end, desc = "Stop" },
    { "<leader>Tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch" },
  },
}
