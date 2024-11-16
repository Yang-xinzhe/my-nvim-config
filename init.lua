-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

require("config.lazy")
require("config.custom")
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
