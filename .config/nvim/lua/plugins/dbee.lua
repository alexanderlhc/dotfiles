return {
  "kndndrj/nvim-dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    -- Install tries to automatically detect the install method.
    -- if it fails, try calling it with one of these parameters:
    --    "curl", "wget", "bitsadmin", "go"
    require("dbee").install()
  end,
  config = function()
    require("dbee").setup({
      sources = {
        require("dbee.sources").MemorySource:new({
          {
            type = "mariadb",
            name = "testdb",
            url = "mariadb://root:password@localhost:3306/",
          },
        }, "testdb"),
        -- require("dbee.sources").FileSource:new(
        --   vim.fn.expand("~/.local/share/dbee.persistence.json")
        -- ),
      }
    })
  end,
}
