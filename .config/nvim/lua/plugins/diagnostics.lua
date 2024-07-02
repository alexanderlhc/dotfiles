-- https://www.reddit.com/r/neovim/comments/1drcd9m/rachartiertinyinlinediagnosticnvim_display/?share_id=NzsugbreTIh56ndwUAubo&utm_content=1&utm_medium=android_app&utm_name=androidcss
return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy",
	config = function()
		require("tiny-inline-diagnostic").setup()
	end,
}
