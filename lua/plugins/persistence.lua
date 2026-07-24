return {
    {
        "folke/persistence.nvim",
        init = function()
            local started_with_stdin = false

            vim.api.nvim_create_autocmd("StdinReadPre", {
                group = vim.api.nvim_create_augroup("custom_session_restore", { clear = true }),
                callback = function()
                    started_with_stdin = true
                end,
            })

            vim.api.nvim_create_autocmd("VimEnter", {
                group = "custom_session_restore",
                nested = true,
                callback = function()
                    if vim.fn.argc(-1) ~= 0 or started_with_stdin then
                        return
                    end

                    vim.schedule(function()
                        require("persistence").load({ last = true })
                    end)
                end,
            })
        end,
    },
}
