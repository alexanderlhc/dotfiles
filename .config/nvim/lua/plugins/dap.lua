return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text"
  },
  keys = {
    {
      "<leader>dut",
      "<Cmd>lua require('dapui').toggle()<CR>",
      desc =
      "DAP UI Toggle State all"
    },
    {
      "<leader>dul",
      "<Cmd>lua require('dapui').toggle(1)<CR>",
      desc =
      "DAP UI Toggle State 1"
    },
    {
      "<leader>dub",
      "<Cmd>lua require('dapui').toggle(2)<CR>",
      desc =
      "DAP UI Toggle State 2"
    },
    {
      "<leader>du",
      "<Cmd>lua require('dapui').toggle()<CR>",
      desc =
      "DAP UI Toggle"
    },
    {
      "<leader>dc",
      "<Cmd>lua require('dap').continue()<CR>",
      desc =
      "DAP Continue"
    },
    {
      "<leader>dov",
      "<Cmd>lua require('dap').step_over()<CR>",
      desc =
      "DAP Step Over"
    },
    {
      "<leader>di",
      "<Cmd>lua require('dap').step_into()<CR>",
      desc =
      "DAP Step Into"
    },
    {
      "<leader>dot",
      "<Cmd>lua require('dap').step_out()<CR>",
      desc =
      "DAP Step Out"
    },
    {
      "<leader>db",
      "<Cmd>lua require('dap').toggle_breakpoint()<CR>",
      desc =
      "DAP Toggle Breakpoint"
    },
    {
      "<leader>dB",
      "<Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
      desc =
      "DAP Set Breakpoint"
    },
    {
      "<leader>dr",
      "<Cmd>lua require('dap').run_to_cursor()<CR>",
      desc =
      "DAP Run To Cursor"
    }
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    local config = {
      breakpoint = {
        text = "",
        texthl = "LspDiagnosticsSignError",
        linehl = "",
        numhl = "",
      },
      breakpoint_rejected = {
        text = "",
        texthl = "LspDiagnosticsSignHint",
        linehl = "",
        numhl = "",
      },
      stopped = {
        text = "",
        texthl = "LspDiagnosticsSignInformation",
        linehl = "DiagnosticUnderlineInfo",
        numhl = "LspDiagnosticsSignInformation",
      },
    }

    vim.fn.sign_define("DapBreakpoint", config.breakpoint)
    vim.fn.sign_define("DapBreakpointRejected", config.breakpoint_rejected)
    vim.fn.sign_define("DapStopped", config.stopped)

    local home = os.getenv("HOME")

    dap.adapters.node2 = {
      type = "executable",
      command = "node",
      args = { home .. "/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
    }
    dap.configurations.typescript = {
      {
        name = "ts-node (Node2 with ts-node)",
        type = "node2",
        request = "launch",
        cwd = vim.loop.cwd(),
        runtimeArgs = { "-r", "ts-node/register", "-r", "tsconfig-paths/register", "-r", "dotenv/config" },
        runtimeExecutable = "node",
        args = { "--inspect", "${file}" },
        sourceMaps = true,
        skipFiles = { "<node_internals>/**", "node_modules/**" },
      },
      {
        name = "Jest (Node2 with ts-node)",
        type = "node2",
        request = "launch",
        cwd = vim.loop.cwd(),
        runtimeArgs = { "--inspect-brk", "${workspaceFolder}/node_modules/.bin/jest" },
        runtimeExecutable = "node",
        args = { "${file}", "--runInBand", "--coverage", "false" },
        sourceMaps = true,
        port = 9229,
        skipFiles = { "<node_internals>/**", "node_modules/**" },
      },
      {
        -- For this to work you need to make sure the node process is started with the `--inspect` flag.
        name = "Attach to process",
        type = "node2",
        request = "attach",
        processId = require("dap.utils").pick_process({
          filter = "node"
        }),
        skipFiles = { "<node_internals>/**", "node_modules/**" },
      },
    }

    vim.g.dap_virtual_text = true

    require("nvim-dap-virtual-text").setup({
      enabled = true,

      -- DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, DapVirtualTextForceRefresh
      enabled_commands = false,

      -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
      highlight_changed_variables = true,
      highlight_new_as_changed = true,

      -- prefix virtual text with comment string
      commented = true,

      show_stop_reason = true,

      -- experimental features:
      virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
      all_frames = false,    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    })

    require("dapui").setup({
      layouts = {
        {
          elements = {
            -- Elements can be strings or table with id and size keys.
            { id = "scopes", size = 0.25 },
            "breakpoints",
            "stacks",
          },
          size = 0.20,
          position = "left",
        },
        {
          elements = { "repl" },
          size = 0.10,
          position = "bottom",
        },
      },
    })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open(0)
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end
}
