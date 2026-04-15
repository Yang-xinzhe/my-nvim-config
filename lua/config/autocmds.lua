-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("custom_auto_right_terminal", { clear = true }),
  pattern = "VeryLazy",
  once = true,
  callback = function()
    vim.schedule(function()
      local cwd = LazyVim.root()
      Snacks.terminal.get(nil, {
        cwd = cwd,
        count = 2,
        win = {
          position = "right",
          width = 0.42,
        },
      })
    end)
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("custom_lsp_keymaps", { clear = true }),
  callback = function(event)
    vim.schedule(function()
      local opts = { buffer = event.buf, silent = true }
      for _, lhs in ipairs({ "gd", "gD", "gr", "gI", "gy", "K" }) do
        pcall(vim.keymap.del, "n", lhs, { buffer = event.buf })
      end
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Goto Definition" }))
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Goto Declaration" }))
      vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
      vim.keymap.set("n", "gI", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Goto Implementation" }))
      vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Goto Type Definition" }))
      vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
    end)
  end,
})
