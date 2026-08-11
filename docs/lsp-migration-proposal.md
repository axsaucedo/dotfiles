# Proposal: coc.nvim → Neovim native LSP

Status: PROPOSAL — no implementation yet. Approve, amend, or reject before any code changes.

## Current state

- coc.nvim (Node.js runtime + its own extension ecosystem) drives completion, diagnostics, go-to-definition, formatting, and code actions.
- ~250 lines of `home/.vimrc` (roughly a quarter of the file) are coc config, plus `coc-settings.json`.
- Installed coc extensions: clangd, cmake, html, json, pairs, snippets, tsserver, ty.
- **Python has no language server at all** — the flake8/black entries in coc-settings belong to `coc-python`, which is deprecated and not installed, so they do nothing.
- Neovim is 0.11.x, which ships native `vim.lsp.config()`/`vim.lsp.enable()`, built-in completion (`vim.lsp.completion`), and default LSP keymaps — the machinery coc reimplements.

## Proposed target

Native LSP via `vim.lsp.enable()` + `nvim-lspconfig` (server definitions only, no framework), with built-in autocompletion. No Node runtime, no extension ecosystem, ~40 lines of Lua replacing the ~250 lines of coc config.

### Server mapping

| Today (coc) | Native replacement | Install |
|---|---|---|
| coc-clangd | `clangd` | already installed (clangd binary) |
| coc-tsserver | `ts_ls` | `npm i -g typescript-language-server` |
| coc-json / coc-html | `jsonls` / `html` | `npm i -g vscode-langservers-extracted` |
| coc-cmake | `neocmake` or `cmake-language-server` | pip/cargo |
| coc-ty | `ty` | already installed |
| *(nothing — gap)* | **`basedpyright`** for Python | `pip install basedpyright` |
| gopls (via coc) | `gopls` | already installed |
| coc-snippets | built-in `vim.snippet` | none |
| coc-pairs | `mini.pairs` (tiny) or nothing | one plugin |

### Keymap mapping

`gd`, `grr` (references), `grn` (rename), `gra` (code action), `K` (hover), `[d`/`]d` (diagnostics) are **Neovim defaults now** — the coc `<Plug>` maps get deleted, not migrated. Custom ones to recreate: `<M-k>` hover+signature, `<leader>f` format, `[e`/`]e` error-only jumps, `:Format`/`:OR` commands, the Go organize-imports-on-save autocmd (becomes a `vim.lsp.buf.code_action` autocmd).

### What is lost and its replacement

- `CocList diagnostics/outline/symbols` → `vim.diagnostic.setqflist()`, fzf `:BTags`, or native `gO`; the `<space>*` maps get rebound.
- coc-snippets → `vim.snippet` (expansion only; no snippet library — add LuaSnip later only if missed).
- Airline coc integration → airline reads `vim.diagnostic` via its nvimlsp extension (one-line change).
- coc floating-window UX polish → native equivalents are close but not identical; this is the main subjective regression risk.

## Migration plan (when approved)

1. Add native LSP config + basedpyright alongside coc, coc disabled via `g:coc_start_at_startup=0` — one session of side-by-side trial.
2. Remove coc plugin, its ~250 config lines, `coc-settings.json`, and the airline coc hooks; rebind the custom maps listed above.
3. Verify per language (python/go/c++/ts/json): diagnostics appear, gd/K/rename/format work, completion pops.

Rollback at any point = revert the commit; coc extensions stay untouched on disk during the trial.

## Recommendation

Do it. The config shrinks by ~200 net lines, Python finally gets a working language server, the Node dependency disappears, and it aligns with the treesitter/lazy.nvim direction of the rest of this PR. The only genuine trade-off is coc's floating-window polish and its curated lists, both of which have serviceable native equivalents.
