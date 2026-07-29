local load_arg_count
local load_opts

package.preload.persistence = function()
    return {
        load = function(...)
            load_arg_count = select("#", ...)
            load_opts = ...
        end,
    }
end

local spec = dofile(vim.fn.stdpath("config") .. "/lua/plugins/persistence.lua")
spec[1].init()

local autocmds = vim.api.nvim_get_autocmds({
    group = "custom_session_restore",
    event = "VimEnter",
})

assert(#autocmds == 1, "session restore must register one VimEnter autocmd")
autocmds[1].callback()
vim.wait(1000, function()
    return load_arg_count ~= nil
end)

assert(load_arg_count == 0, "automatic restore must load the current directory session without options")
assert(load_opts == nil, "automatic restore must not request the global last session")
