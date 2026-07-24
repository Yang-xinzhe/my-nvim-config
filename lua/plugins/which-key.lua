return {
    {
        "folke/which-key.nvim",
        opts = {
            spec = {
                { "<leader>m", group = "Markdown" },
            },
        },
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
