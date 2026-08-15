-- Bootstrap lazy.nvim
local config_dir = vim.fn.stdpath("config")
local vim_dir = vim.fs.normalize(config_dir .. "/../../.vim")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

if not vim.g.lazy_setup_complete then
  local plugins = require("plugins")
  local local_plugins = vim.fn.expand("~/.config/nvim/lua/plugins_local.lua")
  if vim.uv.fs_stat(local_plugins) then
    vim.list_extend(plugins, dofile(local_plugins))
  end

  require("lazy").setup(plugins)
  vim.g.lazy_setup_complete = true

  vim.opt.runtimepath:prepend(vim_dir)
  vim.opt.runtimepath:append(vim_dir .. "/after")
  vim.o.packpath = vim.o.runtimepath

  vim.filetype.add({ extension = { mdx = "markdown.mdx" } })

  local vimrc_local = vim.fn.expand("~/.vimrc.local")
  if vim.fn.filereadable(vimrc_local) == 1 then
    pcall(vim.cmd.source, vim.fn.fnameescape(vimrc_local))
  end
end

for _, module in ipairs({
  "plugins.vim",
  "settings.vim",
  "mappings.vim",
  "functions.vim",
}) do
  vim.cmd.source(vim.fn.fnameescape(config_dir .. "/vim/" .. module))
end

require("lsp")
