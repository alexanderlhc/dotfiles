return {
	"phaazon/hop.nvim",
	version = "2.x.x",
	config = function()
		require("hop").setup()
	end,
	keys = {
		{
			"f",
			function()
				local directions = require("hop.hint").HintDirection
				require("hop").hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
			end,
			desc = "Hop [f]ind forward",
			mode = { "v", "n" },
		},
		{
			"F",
			function()
				local directions = require("hop.hint").HintDirection
				require("hop").hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
			end,
			desc = "Hop [F]ind backward",
			mode = { "v", "n" },
		},
		{
			"t",
			function()
				local directions = require("hop.hint").HintDirection
				require("hop").hint_char1({
					direction = directions.AFTER_CURSOR,
					current_line_only = true,
					hint_offset = -1,
				})
			end,
			desc = "Hop [t]ill forward",
			mode = { "v", "n" },
		},
		{
			"T",
			function()
				local directions = require("hop.hint").HintDirection
				require("hop").hint_char1({
					direction = directions.BEFORE_CURSOR,
					current_line_only = true,
					hint_offset = 1,
				})
			end,
			desc = "Hop [T]ill backward",
			mode = { "v", "n" },
		},
	},
}
