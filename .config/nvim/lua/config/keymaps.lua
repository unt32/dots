-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function open_in_terminal(command)
  local args = { "foot" }
  if command then
    vim.list_extend(args, { "-e", command })
  end

  vim.fn.jobstart(args, {
    cwd = vim.fn.getcwd(),
    detach = true,
  })
end

vim.keymap.set("n", "<leader>wt", open_in_terminal, { desc = "Open terminal in working folder" })
