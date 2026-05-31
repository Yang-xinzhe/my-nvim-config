return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.terminal = opts.terminal or {}
      opts.terminal.start_insert = true
      opts.terminal.auto_insert = false

      opts.terminal.win = opts.terminal.win or {}
      opts.terminal.win.keys = opts.terminal.win.keys or {}

      -- Do not use the default double-escape flow for terminal-normal mode.
      -- Codex uses Esc as an interrupt key, so map a pure Neovim shortcut instead.
      opts.terminal.win.keys.term_normal = {
        "<C-g>",
        "<C-\\><C-n>",
        mode = "t",
        desc = "Terminal Normal Mode",
      }
    end,
  },
}
