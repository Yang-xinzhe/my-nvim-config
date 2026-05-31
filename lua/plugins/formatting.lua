local function in_nvim_config(filename)
  local config_dir = vim.fs.normalize(vim.fn.stdpath("config"))
  local normalized = vim.fs.normalize(filename)
  return normalized == config_dir or normalized:find(config_dir .. "/", 1, true) == 1
end

return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.lua = { "stylua", lsp_format = "never" }
      opts.formatters = opts.formatters or {}
      opts.formatters.stylua = vim.tbl_deep_extend("force", opts.formatters.stylua or {}, {
        prepend_args = function(_, ctx)
          if in_nvim_config(ctx.filename) then
            return { "--config-path", vim.fn.stdpath("config") .. "/stylua.toml" }
          end
          return {}
        end,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.lua_ls = opts.servers.lua_ls or {}
      opts.servers.lua_ls.settings = opts.servers.lua_ls.settings or {}
      opts.servers.lua_ls.settings.Lua = opts.servers.lua_ls.settings.Lua or {}
      opts.servers.lua_ls.settings.Lua.format = vim.tbl_deep_extend(
        "force",
        opts.servers.lua_ls.settings.Lua.format or {},
        {
          defaultConfig = {
            indent_style = "space",
            indent_size = "4",
            tab_width = "4",
          },
        }
      )
    end,
  },
}
