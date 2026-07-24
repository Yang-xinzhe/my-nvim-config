local function feed(keys)
    vim.api.nvim_feedkeys(vim.keycode(keys), "x", false)
end

_G.LazyVim = {
    pick = function()
        return "<Nop>"
    end,
}
dofile(vim.fn.stdpath("config") .. "/lua/config/keymaps.lua")

vim.bo.shiftwidth = 2
vim.bo.expandtab = true
vim.api.nvim_buf_set_lines(0, 0, -1, false, { "first", "second", "third" })

vim.cmd("normal! ggVj")
feed("<Tab>")

local indented = vim.api.nvim_buf_get_lines(0, 0, 2, false)
assert(vim.deep_equal(indented, { "  first", "  second" }), "visual <Tab> must indent every selected line")

feed("<S-Tab>")

local restored = vim.api.nvim_buf_get_lines(0, 0, 2, false)
assert(vim.deep_equal(restored, { "first", "second" }), "visual <S-Tab> must unindent every selected line")
