# Current Buffer Find Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Bind `<C-f>` to an editable current-buffer search prefilled with the word under the cursor.

**Architecture:** Add one normal-mode mapping in the existing global keymap module. Reuse `Snacks.picker.lines` and its `pattern` option; retain the existing LSP reference mapping.

**Tech Stack:** Neovim Lua, LazyVim, snacks.nvim, headless Neovim tests

## Global Constraints

- Search only the current buffer.
- Initialize the query from `vim.fn.expand("<cword>")`.
- Do not change the existing `gr` LSP references mapping.

---

### Task 1: Current-buffer find mapping

**Files:**
- Modify: `tests/keymaps_spec.lua`
- Modify: `lua/config/keymaps.lua`

**Interfaces:**
- Consumes: `Snacks.picker.lines(opts)` and `vim.fn.expand("<cword>")`
- Produces: normal-mode `<C-f>` mapping with description `Find in Current Buffer`

- [ ] **Step 1: Write the failing test**

Stub `Snacks.picker.lines`, place the cursor on `target_function`, invoke the
`<C-f>` mapping callback, and assert `opts.pattern == "target_function"`.

- [ ] **Step 2: Run test to verify it fails**

Run:
`XDG_STATE_HOME=/tmp/nvim-keymap-test-state XDG_CACHE_HOME=/tmp/nvim-keymap-test-cache nvim --headless -l tests/keymaps_spec.lua`

Expected: failure because the normal-mode `<C-f>` mapping has no Lua callback.

- [ ] **Step 3: Write minimal implementation**

Add:

```lua
vim.keymap.set("n", "<C-f>", function()
  Snacks.picker.lines({ pattern = vim.fn.expand("<cword>") })
end, { desc = "Find in Current Buffer" })
```

- [ ] **Step 4: Run test to verify it passes**

Run the command from Step 2. Expected: exit code 0.

- [ ] **Step 5: Run syntax and full regression checks**

Run:
`luac -p lua/config/keymaps.lua tests/keymaps_spec.lua`

Run all documented headless tests that exist in `tests/`.
