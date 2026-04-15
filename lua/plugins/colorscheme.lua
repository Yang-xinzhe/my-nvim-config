return {
  {
    "Mofiqul/vscode.nvim",
    lazy = true,
    opts = {
      transparent = false,
      italic_comments = false,
      italic_inlayhints = true,
      underline_links = true,
      disable_nvimtree_bg = true,
      terminal_colors = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
    config = function(_, opts)
      require("lazyvim").setup(opts)

      local function style_explorer()
        local keep_plain = {
          "Directory",
          "NeoTreeDirectoryName",
          "NeoTreeFileName",
          "NeoTreeFileNameOpened",
          "NeoTreeRootName",
          "NeoTreeGitAdded",
          "NeoTreeGitConflict",
          "NeoTreeGitDeleted",
          "NeoTreeGitIgnored",
          "NeoTreeGitModified",
          "NeoTreeGitUntracked",
        }

        for _, group in ipairs(keep_plain) do
          local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
          if ok and hl and next(hl) ~= nil then
            hl.italic = false
            vim.api.nvim_set_hl(0, group, hl)
          end
        end

        local custom = {
          NeoTreeNormal = { fg = "#d4d4d4", bg = "#181818" },
          NeoTreeNormalNC = { fg = "#d4d4d4", bg = "#181818" },
          NeoTreeEndOfBuffer = { fg = "#181818", bg = "#181818" },
          NeoTreeDirectoryIcon = { fg = "#c5c5c5", bg = "NONE" },
          NeoTreeDirectoryName = { fg = "#d4d4d4", bg = "NONE", bold = false, italic = false },
          NeoTreeFileName = { fg = "#cccccc", bg = "NONE", italic = false },
          NeoTreeFileNameOpened = { fg = "#ffffff", bg = "NONE", bold = true, italic = false },
          NeoTreeRootName = { fg = "#4fc1ff", bg = "NONE", bold = true, italic = false },
          NeoTreeIndentMarker = { fg = "#2d2d30", bg = "NONE" },
          NeoTreeExpander = { fg = "#8c8c8c", bg = "NONE" },
          NeoTreeDotfile = { fg = "#6e7681", bg = "NONE", italic = false },
          NeoTreeHiddenByName = { fg = "#6e7681", bg = "NONE", italic = false },
          NeoTreeGitAdded = { fg = "#81b88b", bg = "NONE", italic = false },
          NeoTreeGitModified = { fg = "#e2c08d", bg = "NONE", italic = false },
          NeoTreeGitDeleted = { fg = "#f14c4c", bg = "NONE", italic = false },
          NeoTreeGitConflict = { fg = "#c586c0", bg = "NONE", italic = false },
          NeoTreeGitIgnored = { fg = "#6e7681", bg = "NONE", italic = false },
          NeoTreeGitUntracked = { fg = "#73c991", bg = "NONE", italic = false },
        }

        for group, value in pairs(custom) do
          vim.api.nvim_set_hl(0, group, value)
        end
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = style_explorer,
      })
      style_explorer()
    end,
  },
}
