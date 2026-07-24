return {
    {
        "lewis6991/gitsigns.nvim",
        opts = function(_, opts)
            opts.current_line_blame = true
            opts.current_line_blame_opts = vim.tbl_deep_extend("force", opts.current_line_blame_opts or {}, {
                delay = 500,
                virt_text = true,
                virt_text_pos = "eol",
                use_focus = true,
            })
            opts.current_line_blame_formatter = " <author>, <author_time:%Y-%m-%d> - <summary> "

            Snacks.toggle({
                name = "Git Blame",
                get = function()
                    return require("gitsigns.config").config.current_line_blame
                end,
                set = function(enabled)
                    require("gitsigns").toggle_current_line_blame(enabled)
                end,
            }):map("<leader>uB")
        end,
    },
}
