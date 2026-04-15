return {
  {
    "plasticboy/vim-markdown",
    ft = { "markdown" },
    init = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_conceal = 0
      vim.g.vim_markdown_math = 1
      vim.g.vim_markdown_new_list_item_indent = 2
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    build = "cd app && npx --yes yarn install --frozen-lockfile",
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview Toggle" },
      { "<leader>mP", "<cmd>MarkdownPreviewStop<cr>", desc = "Markdown Preview Stop" },
    },
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_open_to_the_world = 0

      if vim.fn.has("wsl") == 1 then
        vim.g.mkdp_browserfunc = "MkdpOpenInWindows"
        vim.cmd([[
          function! MkdpOpenInWindows(url) abort
            call jobstart([
                  \ '/mnt/c/Windows/System32/cmd.exe',
                  \ '/c',
                  \ 'start',
                  \ '',
                  \ a:url
                  \ ], { 'detach': v:true })
          endfunction
        ]])
      end
    end,
  },
}
