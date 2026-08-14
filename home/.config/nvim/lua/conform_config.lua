local function available(command)
  return vim.fn.executable(command) == 1 and vim.system({ command, "--version" }):wait().code == 0
end

local formatters = {}
if available("ruff") then
  formatters.python = { "ruff_format" }
elseif available("black") then
  formatters.python = { "black" }
end
if vim.fn.executable("gofmt") == 1 then
  formatters.go = { "gofmt" }
end
if available("stylua") then
  formatters.lua = { "stylua" }
end
if available("clang-format") then
  formatters.c = { "clang-format" }
  formatters.cpp = { "clang-format" }
end
if available("prettier") then
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
