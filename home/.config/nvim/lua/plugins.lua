return {
  -- Nerd tree side directory
  {
    "scrooloose/nerdtree",
    cmd = { "NERDTree", "NERDTreeToggle", "NERDTreeFind" },
    dependencies = { "Xuyuanp/nerdtree-git-plugin" },
  },
  -- NERDTree git plugin
  { "Xuyuanp/nerdtree-git-plugin", lazy = true },
  -- fuzzy search
  { "junegunn/fzf", build = ":call fzf#install()" },
  { "junegunn/fzf.vim" },
  -- Colour parentheses
  { "luochen1990/rainbow", event = { "BufReadPost", "BufNewFile" } },
  -- Multiple cursors
  { "mg979/vim-visual-multi", event = "VeryLazy" },
  -- Navigation between tmux and vim
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
  },
  -- Fugitive plugin
  { "tpope/vim-fugitive", cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Ggrep" } },
  -- Bulletpoint plug
  { "dkarter/bullets.vim", ft = { "markdown", "text", "gitcommit", "scratch" } },
  -- Native LSP server definitions
  { "neovim/nvim-lspconfig", lazy = false },
  -- Vim airline status line
  { "vim-airline/vim-airline", event = "VeryLazy", dependencies = { "vim-airline/vim-airline-themes" } },
  { "vim-airline/vim-airline-themes", lazy = true },
  -- Tokynight theme
  { "folke/tokyonight.nvim", branch = "main", lazy = true },
  { "loctvl842/monokai-pro.nvim", lazy = true },
  -- Vim Repeat
  { "tpope/vim-repeat", event = "VeryLazy" },
  -- Vim Easyclip (Disable if mac)
  -- { "svermeulen/vim-easyclip" },
  -- Avoid copying on every cut operation instead cut with mm
  { "svermeulen/vim-cutlass", event = "VeryLazy" },
  -- Syntax for headlines
  { "lukas-reineke/headlines.nvim", ft = { "markdown", "markdown.mdx" } },
  -- Vim Markdown
  { "godlygeek/tabular", cmd = "Tabularize" },
  { "preservim/vim-markdown", event = "InsertEnter" },
  -- We use Pandoc instead as more consistent syntax than above
  { "vim-pandoc/vim-pandoc", event = "InsertEnter" },
  { "vim-pandoc/vim-pandoc-syntax", event = "InsertEnter" },
  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  -- Vim Table Mode (Toggle with :TableModeToggle)
  -- { "dhruvasagar/vim-table-mode" },
  -- Dim inactive (First plugin is to listen to tmux events, other to dim)
  -- { "tmux-plugins/vim-tmux-focus-events" },
  -- { "blueyed/vim-diminactive" }, -- Linked to plugin above
  -- Colour picker
  { "KabbAmine/vCoolor.vim", cmd = "VCoolor" },
  -- Add colours to hex
  { "etdev/vim-hexcolor", event = { "BufReadPost", "BufNewFile" } },
  -- Sidebar minimap
  -- { "wfxr/minimap.vim" },
  -- close tags
  { "alvan/vim-closetag", ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact" } },
  -- Shortcuts to add/remove quotes/brances on selection
  { "tpope/vim-surround", event = "VeryLazy" },
  -- Multi-language syntax support
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      vim.list = vim.list or {
        unique = function(items)
          local seen = {}
          return vim.tbl_filter(function(item)
            local new = not seen[item]
            seen[item] = true
            return new
          end, items)
        end,
      }
    end,
    config = function()
      require("nvim-treesitter").install({
        "python",
        "go",
        "cpp",
        "c",
        "lua",
        "vim",
        "vimdoc",
        "javascript",
        "typescript",
        "json",
        "yaml",
        "bash",
        "markdown",
        "markdown_inline",
        "cmake",
        "html",
        "css",
      })
      local filetypes = {
        "python",
        "go",
        "cpp",
        "c",
        "lua",
        "vim",
        "vimdoc",
        "javascript",
        "typescript",
        "json",
        "yaml",
        "sh",
        "cmake",
        "html",
        "css",
      }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function()
          vim.treesitter.start()
        end,
      })
      if vim.list_contains(filetypes, vim.bo.filetype) then
        vim.treesitter.start()
      end
    end,
  },
  -- Advanced syntax support for cpp
  { "octol/vim-cpp-enhanced-highlight", ft = { "c", "cpp" } },
  -- Search and replace
  { "MagicDuck/grug-far.nvim", cmd = "GrugFar", opts = {} },
  -- Cmake syntax
  { "pboettch/vim-cmake-syntax", ft = "cmake" },
  -- Show the current / previous function
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("treesitter-context").setup({})
    end,
  },
  -- Animations
  {
    "axsaucedo/neovim-power-mode",
    event = "InsertEnter",
    init = function()
      vim.g.power_mode_auto_enable = 1
      vim.g.power_mode_particle_preset = "rightburst"
      vim.g.power_mode_particle_cancel_on_new = 1
      vim.g.power_mode_shake_mode = "none"
      vim.g.power_mode_fire_wall_enabled = 0
      vim.g.power_mode_combo_enabled = 1
      vim.g.power_mode_combo_position = "top-right"
      vim.g.power_mode_color_1 = "#FF0000"
      vim.g.hud_linter_duration = 2
    end,
  },
  {
    "sphamba/smear-cursor.nvim",
    event = { "CursorMoved", "CursorMovedI" },
    config = function()
      require("smear_cursor").enabled = true
    end,
  },
  {
    "rachartier/tiny-glimmer.nvim",
    event = "TextYankPost",
    config = function()
      require("tiny-glimmer").setup({ enabled = true })
    end,
  },
}
