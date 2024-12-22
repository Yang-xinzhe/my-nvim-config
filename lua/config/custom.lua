return {
  "saghen/blink.cmp",
  ---@class PluginLspOpts
  opts = {
    signature = { enabled = true },
    keymap = {
      preset = "default",
    },
    servers = {
      clangd = {
        cmd = {
          "clangd",
          "--header-insertion=never", -- 禁用头文件自动插入
          "--header-insertion-decorators=false", -- 禁用头文件修饰提示
        },
      },
    },
  },
  -- 添加 vim-markdown 插件
  {
    "plasticboy/vim-markdown",
    ft = { "markdown" }, -- 仅在打开 Markdown 文件时加载
    config = function()
      -- 可选配置
      vim.g.vim_markdown_folding_disabled = 1 -- 禁用折叠功能
      vim.g.vim_markdown_conceal = 0 -- 禁用隐藏符号
      vim.g.vim_markdown_math = 1 -- 启用数学公式支持
      vim.g.vim_markdown_new_list_item_indent = 2 -- 设置新列表项的缩进
    end,
  },
}
