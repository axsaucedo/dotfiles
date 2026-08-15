-- Same idea as the shell's tips box: the less-used goodies are easy to
-- forget, so every vim start shows one at random. :Tips lists them all.
local TIPS = {
  "gd / grr -- LSP definition / references         K -- hover docs",
  "grn -- LSP rename          gra -- code action",
  "[e ]e -- jump between errors    <space>a -- Trouble diagnostics panel",
  "<space>w / :Warnings -- toggle warnings (editor shows errors only by default)",
  ",f / :Format -- format buffer (black, gofmt, LSP fallback)",
  "<space>s / <space>o -- fuzzy document / workspace symbols",
  "ctrl+p ctrl+f -- live grep project    ctrl+p ctrl+g -- git grep",
  "Tab -- accept completion; docs pop up automatically",
  ", (wait a moment) -- which-key shows everything behind the leader",
  ":OR -- organize imports (automatic on save for Go)",
}

vim.api.nvim_create_user_command("Tips", function()
  print(table.concat(TIPS, "\n"))
end, {})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local tip = " " .. TIPS[math.random(#TIPS)] .. " "
    local width = vim.fn.strdisplaywidth(tip)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { tip })
    local win = vim.api.nvim_open_win(buf, false, {
      relative = "editor",
      anchor = "SE",
      row = vim.o.lines - 2,
      col = vim.o.columns,
      width = width,
      height = 1,
      style = "minimal",
      border = "rounded",
      focusable = false,
    })
    vim.defer_fn(function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end, 8000)
  end,
})
