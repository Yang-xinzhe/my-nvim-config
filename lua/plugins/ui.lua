return {
  {
    "snacks.nvim",
    opts = function(_, opts)
      opts.dashboard = opts.dashboard or {}
      opts.dashboard.wo = vim.tbl_deep_extend("force", opts.dashboard.wo or {}, {
        number = false,
        relativenumber = false,
        signcolumn = "no",
        statuscolumn = "",
      })
    end,
  },

  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.always_show_bufferline = true
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections = opts.sections or {}
      opts.sections.lualine_c = opts.sections.lualine_c or {}

      table.insert(opts.sections.lualine_c, {
        function()
          return "● Unsaved"
        end,
        cond = function()
          return vim.bo.modified
        end,
        color = { fg = "#e5c07b", gui = "bold" },
      })
    end,
  },
}
