local M = {}

function M.setup()
    local theme = require('github-theme')

    theme.setup({
	theme_style = "light"
    })
end

return M
