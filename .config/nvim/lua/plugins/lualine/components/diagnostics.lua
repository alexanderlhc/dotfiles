local icons = require("config.icons")

return {
	"diagnostics",
	symbols = {
		error = icons.diagnostics.Error,
		warn = icons.diagnostics.Warn,
		info = icons.diagnostics.Info,
		hint = icons.diagnostics.Hint,
	},
}
