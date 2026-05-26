return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<leader>tt]],
      direction = "horizontal",
      size = 15,
    })
  end,
}
