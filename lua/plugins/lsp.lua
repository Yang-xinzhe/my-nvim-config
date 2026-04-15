return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    servers = {
      clangd = {
        cmd = {
          "clangd",
          "--header-insertion=never",
          "--header-insertion-decorators=false",
        },
      },
    },
  },
}
