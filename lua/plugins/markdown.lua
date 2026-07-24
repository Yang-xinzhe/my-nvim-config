return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        opts = {},
        keys = {
            { "<A-v>", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown", desc = "Toggle Markdown Render" },
            {
                "<leader>mp",
                "<cmd>RenderMarkdown toggle<cr>",
                ft = "markdown",
                desc = "Toggle Markdown Render (Alt-v)",
            },
        },
    },
}
