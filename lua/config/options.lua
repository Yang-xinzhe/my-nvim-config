-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.lazyvim_picker = "snacks"
vim.g.autoformat = false

local function apply_local_options()
  vim.opt_global.tabstop = 4
  vim.opt_global.shiftwidth = 4
  vim.opt_global.softtabstop = 4
  vim.opt_global.expandtab = true
  vim.opt_global.number = true
  vim.opt_global.relativenumber = false
end

apply_local_options()

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("custom_local_option_overrides", { clear = true }),
  pattern = "VeryLazy",
  once = true,
  callback = apply_local_options,
})
