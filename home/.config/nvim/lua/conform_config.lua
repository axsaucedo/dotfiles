-- Static formatter table: no subprocess probing here. This file loads on
-- the first save of every session (conform's BufWritePre event), and the
-- old `<cmd> --version` checks spawned pyenv shims costing ~1.5s per :wq.
local formatters = {}
-- ruff would be preferred, but its pyenv shim is currently broken; swap
-- back to { "ruff_format" } once `ruff --version` works again
if vim.fn.executable("black") == 1 then
  formatters.python = { "black" }
end
if vim.fn.executable("gofmt") == 1 then
  formatters.go = { "gofmt" }
end
if vim.fn.executable("stylua") == 1 then
  formatters.lua = { "stylua" }
end
if vim.fn.executable("clang-format") == 1 then
  formatters.c = { "clang-format" }
  formatters.cpp = { "clang-format" }
end
if vim.fn.executable("prettier") == 1 then
  for _, filetype in ipairs({ "json", "typescript", "javascript", "html" }) do
    formatters[filetype] = { "prettier" }
  end
end

return {
  formatters_by_ft = formatters,
  format_on_save = function(bufnr)
    if vim.bo[bufnr].filetype == "go" then
      return { lsp_format = "fallback" }
    end
  end,
}
