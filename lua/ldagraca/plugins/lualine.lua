return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    lualine.setup({
      options = {
        theme = "tokyonight",
      },
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          {
            function()
              return require("herdr-nvim").statusline()
            end,
            cond = function()
              local ok, herdr = pcall(require, "herdr-nvim")
              return ok and herdr.statusline() ~= ""
            end,
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
      },
    })
  end,
}

