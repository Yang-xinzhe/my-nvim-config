-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function start_terminal_insert()
  vim.cmd.startinsert()
end

local function apply_normal_buffer_options(buf)
  if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].buftype ~= "" then
    return
  end

  local excluded = {
    snacks_dashboard = true,
    dashboard = true,
    alpha = true,
    ministarter = true,
    snacks_terminal = true,
    neo_tree = true,
    ["neo-tree"] = true,
    lazy = true,
    mason = true,
    qf = true,
  }

  if excluded[vim.bo[buf].filetype] then
    return
  end

  vim.bo[buf].tabstop = 4
  vim.bo[buf].shiftwidth = 4
  vim.bo[buf].softtabstop = 4
  vim.bo[buf].expandtab = true
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("custom_terminal_keymaps", { clear = true }),
  pattern = "snacks_terminal",
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }

    -- Snacks terminals use terminal-normal mode for browsing output.
    -- Make it easy to jump back into the running shell or TUI.
    vim.keymap.set("n", "<CR>", start_terminal_insert, vim.tbl_extend("force", opts, { desc = "Terminal Insert Mode" }))
    vim.keymap.set("n", "i", start_terminal_insert, vim.tbl_extend("force", opts, { desc = "Terminal Insert Mode" }))
    vim.keymap.set("n", "a", start_terminal_insert, vim.tbl_extend("force", opts, { desc = "Terminal Insert Mode" }))
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  group = vim.api.nvim_create_augroup("custom_normal_buffer_options", { clear = true }),
  callback = function(event)
    apply_normal_buffer_options(event.buf)
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("custom_local_config_autoformat", { clear = true }),
  pattern = vim.fn.stdpath("config") .. "/**/*",
  callback = function()
    vim.b.autoformat = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("custom_dashboard_window_options", { clear = true }),
  pattern = { "snacks_dashboard", "dashboard", "alpha", "ministarter" },
  callback = function(event)
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(event.buf) then
        return
      end
      local wins = vim.fn.win_findbuf(event.buf)
      for _, win in ipairs(wins) do
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_call(win, function()
            vim.opt_local.number = false
            vim.opt_local.relativenumber = false
            vim.opt_local.statuscolumn = ""
            vim.opt_local.signcolumn = "no"
            vim.opt_local.foldcolumn = "0"
          end)
        end
      end
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
