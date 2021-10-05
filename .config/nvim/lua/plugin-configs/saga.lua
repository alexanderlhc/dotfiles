local saga = require 'lspsaga'

saga.init_lsp_saga {
  finder_action_keys = {
    tabedit = 't', open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
  },
  -- use_saga_diagnostic_sign = true,
  -- error_sign = '',
  -- warn_sign = '',
  -- hint_sign = '',
  -- infor_sign = '',
  -- dianostic_header_icon = '   ',
  -- code_action_icon = ' '
}
