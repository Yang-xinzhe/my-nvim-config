return {
  {
    "folke/which-key.nvim",
    keys = {
      {
        "<c-w>",
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end,
        mode = "n",
        desc = "Window Keymaps (which-key)",
      },
    },
  },
}
