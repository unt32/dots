return {
  {
    "mofiqul/vscode.nvim",
    config = function()
      require("vscode").setup({
        transparent = true,
      })
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },
}
