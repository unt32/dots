return {
  "mofiqul/vscode.nvim",
  config = function()
    require("vscode").setup({
      transparent = true,
    })
    vim.cmd([[colorscheme vscode]]) -- Don't forget to actually set the colorscheme!
  end,
}
