local M = {}

local function fzf()
  return require("fzf-lua")
end

function M.files()
  if vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" }):match("true") then
    fzf().git_files()
  else
    fzf().files()
  end
end

function M.setup()
  local commands = {
    Ag = { function(args) fzf().grep({ search = args.args }) end, "*" },
    BLines = { function() fzf().blines() end, 0 },
    Buffers = { function() fzf().buffers() end, 0 },
    Colors = { function() fzf().colorschemes() end, 0 },
    Commits = { function() fzf().git_commits() end, 0 },
    Files = { function(args) fzf().files({ cwd = args.args ~= "" and args.args or nil }) end, "?" },
    GFiles = { function(args) fzf().git_files({ cwd = args.args ~= "" and args.args or nil }) end, "?" },
    GGrep = { function(args)
      fzf().live_grep({ cmd = "git grep --line-number --column --color=always", query = args.args })
    end, "*" },
    Tags = { function() fzf().tags({ query = vim.fn.expand("<cword>") }) end, 0 },
  }
  for name, command in pairs(commands) do
    vim.api.nvim_create_user_command(name, command[1], { bang = true, nargs = command[2] })
  end

  vim.keymap.set("n", "<C-p><C-p>", M.files)
  vim.keymap.set("n", "<C-p><C-a>", function() commands.Files[1]({ args = "" }) end)
  vim.keymap.set("n", "<C-p><C-b>", commands.Buffers[1])
  vim.keymap.set("n", "<C-p><C-f>", function() fzf().grep_project() end)
  vim.keymap.set("n", "<C-p><C-g>", function() commands.GGrep[1]({ args = "" }) end)
  vim.keymap.set("n", "<C-p><C-t>", commands.Tags[1])
  vim.keymap.set("n", "<C-p><C-l>", commands.BLines[1])
  vim.keymap.set("n", "<C-p><C-c>", commands.Commits[1])
end

return M
