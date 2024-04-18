return {
	"echasnovski/mini.ai",
	version = "*",
	opts = function()
		return {
			custom_textobjects = {
				o = require("mini.ai").gen_spec.treesitter({
					a = { "@block.outer", "@conditional_outer", "@loop_outer" },
					i = { "@block.inner", "@conditional_inner", "@loop_inner" },
				}),
				f = require("mini.ai").gen_spec.treesitter({
					a = { "@function.outer" },
					i = { "@function.inner" },
				}),
				c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
				d = { "%f[%d]%d+" }, -- digits
				e = { -- Word with case
					{
						"%u[%l%d]+%f[^%l%d]",
						"%f[%S][%l%d]+%f[^%l%d]",
						"%f[%P][%l%d]+%f[^%l%d]",
						"^[%l%d]+%f[^%l%d]",
					},
					"^().*()$",
				},
				g = function() -- Whole buffer, similar to `gg` and 'G' motion
					local from = { line = 1, col = 1 }
					local to = {
						line = vim.fn.line("$"),
						col = math.max(vim.fn.getline("$"):len(), 1),
					}
					return { from = from, to = to }
				end,
				u = require("mini.ai").gen_spec.function_call(), -- u for "Usage"
				U = require("mini.ai").gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
			},
		}
	end,
	config = function(_, opts)
		require("mini.ai").setup(opts)

		-- Add keymaps
		local i = {
			[" "] = "Whitespace",
			['"'] = 'Balanced "',
			["'"] = "Balanced '",
			["`"] = "Balanced `",
			["("] = "Balanced (",
			[")"] = "Balanced ) including white-space",
			[">"] = "Balanced > including white-space",
			["<lt>"] = "Balanced <",
			["]"] = "Balanced ] including white-space",
			["["] = "Balanced [",
			["}"] = "Balanced } including white-space",
			["{"] = "Balanced {",
			["?"] = "User Prompt",
			_ = "Underscore",
			a = "Argument",
			b = "Balanced ), ], }",
			c = "Class",
			d = "Digit(s)",
			e = "Word in CamelCase & snake_case",
			f = "Function",
			g = "Entire file",
			o = "Block, conditional, loop",
			q = "Quote `, \", '",
			t = "Tag",
			u = "Use/call function & method",
			U = "Use/call without dot in name",
		}

		local a = vim.deepcopy(i)
		for k, v in pairs(a) do
			a[k] = v:gsub(" including.*", "")
		end

		local ic = vim.deepcopy(i)
		local ac = vim.deepcopy(a)
		for key, name in pairs({ n = "Next", l = "Last" }) do
			i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
			a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
		end
		require("which-key").register({
			mode = { "o", "x" },
			i = i,
			a = a,
		})
	end,
}
