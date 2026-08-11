local servers = { "basedpyright", "ts_ls", "jsonls", "html", "clangd", "gopls" }
if #vim.api.nvim_get_runtime_file("lsp/ty.lua", false) > 0 then
  table.insert(servers, "ty")
end
vim.lsp.enable(servers)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})

local function organize_imports()
  local client = vim.lsp.get_clients({ bufnr = 0, method = "textDocument/codeAction" })[1]
  if not client then
    return
  end

  local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
  params.context = { only = { "source.organizeImports" }, diagnostics = {} }
  local response = client:request_sync("textDocument/codeAction", params, 1000, 0)
  for _, action in ipairs(response and response.result or {}) do
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
    end
    if action.command then
      client:exec_cmd(type(action.command) == "table" and action.command or action, { bufnr = 0 })
    end
  end
end

vim.keymap.set("n", "<M-k>", function()
  vim.lsp.buf.hover()
  vim.lsp.buf.signature_help()
end)
vim.keymap.set({ "n", "x" }, "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "[e", function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", "]e", function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end)

vim.keymap.set("n", "<space>a", vim.diagnostic.setqflist)
vim.keymap.set("n", "<space>s", vim.lsp.buf.document_symbol)
vim.keymap.set("n", "<space>o", vim.lsp.buf.workspace_symbol)

vim.api.nvim_create_user_command("Format", function()
  vim.lsp.buf.format()
end, {})
vim.api.nvim_create_user_command("OR", organize_imports, {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = organize_imports,
})
