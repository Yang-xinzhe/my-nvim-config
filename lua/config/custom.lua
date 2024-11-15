-- 自定义 nvim-cmp 配置，Tab 键用于确认补全，Enter 键用于选择下一个补全项

local cmp = require("cmp")

cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Tab 键确认选择
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item() -- Enter 键选择下一个补全项
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item() -- Shift+Tab 选择上一个补全项
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "emoji" },
  },
})
