# Current Buffer Find Design

## Goal

Make `<C-f>` behave like VSCode's current-file Find: open an interactive result
list for the current buffer and prefill the query with the word under the cursor.

## Design

Use the already configured Snacks picker and call `Snacks.picker.lines()` from a
normal-mode mapping. Pass `vim.fn.expand("<cword>")` as the initial `pattern`, so
the query remains editable after the picker opens. Keep the existing buffer-local
`gr` LSP mapping unchanged for finding references and call sites.

## Verification

Extend the headless keymap test with a Snacks stub, invoke the `<C-f>` callback,
and assert that the lines picker receives the cursor word as its pattern.
