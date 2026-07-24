return {
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "LazyFile",
        opts = function()
            local context = require("treesitter-context")

            Snacks.toggle({
                name = "Sticky Code Context",
                get = context.enabled,
                set = function(enabled)
                    if enabled then
                        context.enable()
                    else
                        context.disable()
                    end
                end,
            }):map("<leader>uc")

            return {
                mode = "cursor",
                max_lines = 3,
            }
        end,
    },
}
