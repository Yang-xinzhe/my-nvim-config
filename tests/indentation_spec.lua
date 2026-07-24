vim.cmd.edit("/tmp/nvim-indentation-spec.c")
vim.cmd("setfiletype c")
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = false

dofile(vim.fn.stdpath("config") .. "/lua/config/autocmds.lua")

assert(vim.bo.tabstop == 4, "the initial code buffer must use a tab width of 4")
assert(vim.bo.shiftwidth == 4, "the initial code buffer must indent by 4 spaces")
assert(vim.bo.softtabstop == 4, "the initial code buffer must insert 4 spaces for Tab")
assert(vim.bo.expandtab, "the initial code buffer must expand tabs to spaces")

vim.api.nvim_buf_set_lines(0, 0, -1, false, { "if (ready) {", "value = 1;", "}" })
vim.cmd("normal! gg=G")

assert(vim.fn.indent(2) == 4, "a C statement inside an if block must be indented by 4 spaces")
