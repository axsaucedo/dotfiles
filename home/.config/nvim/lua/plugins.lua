return {
  -- File explorer sidebar (won the trial against NERDTree and oil.nvim)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" },
    cmd = "Neotree",
    keys = {
      { "M", "<cmd>Neotree toggle<cr>" },
      { "<leader>e", "<cmd>Neotree toggle<cr>" },
    },
    opts = {
      filesystem = {
        filtered_items = { visible = true },
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_default",
      },
      window = {
        mappings = {
          -- curated cheatsheet instead of the auto-generated mapping dump
          ["?"] = function()
            local lines = {
              " Enter      open file / expand-collapse folder ",
              " Backspace  go up: parent becomes the root ",
              " .          make selected folder the root ",
              " a / A      add file / add directory ",
              " r          rename          d  delete ",
              " x / y / p  cut / copy / paste ",
              " s / S      open in vsplit / split ",
              " H          toggle hidden   R  refresh ",
              " /          filter tree (Esc clears) ",
              " q          close sidebar ",
            }
            -- pressing ? again closes an open cheatsheet (toggle)
            if vim.g.neotree_help_win and vim.api.nvim_win_is_valid(vim.g.neotree_help_win) then
              vim.api.nvim_win_close(vim.g.neotree_help_win, true)
              vim.g.neotree_help_win = nil
              return
            end
            local buf = vim.api.nvim_create_buf(false, true)
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
            local win = vim.api.nvim_open_win(buf, false, {
              relative = "cursor",
              row = 1,
              col = 0,
              width = 44,
              height = #lines,
              style = "minimal",
              border = "rounded",
            })
            vim.g.neotree_help_win = win
            -- any movement or action in the tree dismisses it
            vim.api.nvim_create_autocmd({ "CursorMoved", "ModeChanged", "BufLeave", "WinLeave" }, {
              once = true,
              callback = function()
                if vim.api.nvim_win_is_valid(win) then
                  vim.api.nvim_win_close(win, true)
                end
                vim.g.neotree_help_win = nil
              end,
            })
          end,
        },
      },
    },
  },
  -- Fuzzy search
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    init = function()
      require("fzf_config").setup()
    end,
    opts = {},
  },
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
    -- cmd-only lazy loading meant the plugin's <C-hjkl> maps never got
    -- created; declare them here so the keys work and trigger the load
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>" },
    },
  },
  -- Fugitive plugin
  { "tpope/vim-fugitive", cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Ggrep" } },
  -- Bulletpoint plug
  { "dkarter/bullets.vim", ft = { "markdown", "text", "gitcommit", "scratch" } },
  -- Native LSP server definitions
  { "neovim/nvim-lspconfig", lazy = false },
  -- Completion
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    opts = {
      -- super-tab: Tab accepts/cycles like coc did
      keymap = { preset = "super-tab" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        -- keep buffer words from flooding the menu
        providers = {
          buffer = { max_items = 4, score_offset = -5 },
        },
      },
      completion = { documentation = { auto_show = true } },
    },
  },
  -- Formatting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    opts = function()
      return require("conform_config")
    end,
  },
  -- Keymap help
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
  -- Diagnostics panel
  { "folke/trouble.nvim", cmd = "Trouble", opts = {} },
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
    -- The plugin auto-setups on VimEnter, which has already fired by the
    -- time InsertEnter loads it — call setup explicitly instead.
    config = function()
      require("power-mode").setup()
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
