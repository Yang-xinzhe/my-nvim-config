return {
    {
        "nvim-mini/mini.map",
        event = "VeryLazy",
        config = function()
            local map = require("mini.map")
            local enabled = true

            map.setup({
                integrations = {
                    map.gen_integration.diagnostic({
                        error = "DiagnosticFloatingError",
                        warn = "DiagnosticFloatingWarn",
                    }),
                    map.gen_integration.gitsigns(),
                    map.gen_integration.builtin_search(),
                },
                window = {
                    side = "right",
                    width = 12,
                    winblend = 25,
                },
            })

            local function can_open()
                return vim.bo.buftype == "" and vim.bo.filetype ~= "" and not vim.b.bigfile
            end

            local function refresh_visibility()
                if enabled and can_open() then
                    map.open()
                else
                    map.close()
                end
            end

            vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
                group = vim.api.nvim_create_augroup("custom_minimap_visibility", { clear = true }),
                callback = function()
                    vim.schedule(refresh_visibility)
                end,
            })

            Snacks.toggle({
                name = "Minimap",
                get = function()
                    return enabled
                end,
                set = function(state)
                    enabled = state
                    refresh_visibility()
                end,
            }):map("<leader>um")

            vim.schedule(refresh_visibility)
        end,
    },
}
