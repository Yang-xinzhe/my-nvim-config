local function feed(keys)
    vim.api.nvim_feedkeys(vim.keycode(keys), "x", false)
end

_G.LazyVim = {
    pick = function()
        return "<Nop>"
    end,
}

local lines_opts
_G.Snacks = {
    picker = {
        lines = function(opts)
            lines_opts = opts
        end,
        keymaps = function() end,
        colorschemes = function() end,
    },
}
dofile(vim.fn.stdpath("config") .. "/lua/config/keymaps.lua")

vim.bo.shiftwidth = 2
vim.bo.expandtab = true
vim.api.nvim_buf_set_lines(0, 0, -1, false, { "first target_function", "second", "third" })

vim.api.nvim_win_set_cursor(0, { 1, 8 })
local ctrl_f = vim.fn.maparg("<C-f>", "n", false, true)
assert(type(ctrl_f.callback) == "function", "normal <C-f> must have a Lua callback")
ctrl_f.callback()
assert(lines_opts.pattern == "target_function", "<C-f> must prefill the word under the cursor")

vim.cmd("normal! ggVj")
feed("<Tab>")

local indented = vim.api.nvim_buf_get_lines(0, 0, 2, false)
assert(
    vim.deep_equal(indented, { "  first target_function", "  second" }),
    "visual <Tab> must indent every selected line"
)

feed("<S-Tab>")

local restored = vim.api.nvim_buf_get_lines(0, 0, 2, false)
assert(
    vim.deep_equal(restored, { "first target_function", "second" }),
    "visual <S-Tab> must unindent every selected line"
)
