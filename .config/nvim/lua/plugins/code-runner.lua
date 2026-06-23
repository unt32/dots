return {
  {
    "CRAG666/code_runner.nvim",
    cmd = { "RunCode", "RunFile", "RunProject", "CRFiletype", "CRProjects" },
    keys = {
      { "<leader>rr", ":RunCode<CR>", desc = "Run Code" },
      { "<leader>rf", ":RunFile<CR>", desc = "Run File" },
      { "<leader>rp", ":RunProject<CR>", desc = "Run Project" },
    },
    opts = {
      mode = "term",
      focus = true,
      startinsert = true,
      term = {
        size = 12
      },
      filetype = {
        python = "python3 -u",
        javascript = "node",
        typescript = "deno run",
        rust = "cd $dir && cargo run",
        c = "cd $dir && gcc $fileName -o $fileNameWithoutExt.out && $dir/$fileNameWithoutExt.out",
        cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt.out && $dir/$fileNameWithoutExt.out",
        go = "go run",
      },
    },
  },
}
