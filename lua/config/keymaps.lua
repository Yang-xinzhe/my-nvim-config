-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function right_terminal(cwd, count)
  return function()
    local dir = type(cwd) == "function" and cwd() or cwd
    Snacks.terminal(nil, {
      cwd = dir,
      count = count,
      win = {
        position = "right",
        width = 0.42,
      },
    })
  end
end

local function resize_window(cmd)
  return function()
    vim.cmd(cmd)
    if vim.api.nvim_get_mode().mode == "t" then
      vim.cmd.startinsert()
    end
  end
end

vim.keymap.set("n", "<C-p>", LazyVim.pick("files"), { desc = "Find Files (Root Dir)" })
vim.keymap.set("n", "<leader>sg", LazyVim.pick("live_grep"), { desc = "Grep (Root Dir)" })
vim.keymap.set("n", "<leader>sk", function()
  Snacks.picker.keymaps()
end, { desc = "Search Keymaps" })
vim.keymap.set("n", "<leader>ut", function()
  Snacks.picker.colorschemes()
end, { desc = "Theme Picker" })
vim.keymap.set("n", "<leader>fv", right_terminal(function()
  return LazyVim.root()
end, 2), { desc = "Terminal Right (Root Dir)" })
vim.keymap.set("n", "<leader>fV", right_terminal(function()
  return vim.uv.cwd()
end, 3), { desc = "Terminal Right (cwd)" })
vim.keymap.set({ "n", "t" }, "<C-Left>", resize_window("vertical resize -2"), { desc = "Decrease Window Width" })
vim.keymap.set({ "n", "t" }, "<C-Right>", resize_window("vertical resize +2"), { desc = "Increase Window Width" })
vim.keymap.set({ "n", "t" }, "<C-Up>", resize_window("resize +2"), { desc = "Increase Window Height" })
vim.keymap.set({ "n", "t" }, "<C-Down>", resize_window("resize -2"), { desc = "Decrease Window Height" })
