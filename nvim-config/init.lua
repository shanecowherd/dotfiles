-- Packer bootstrap (safe to add at the top if it's not already there)
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      "git", "clone", "--depth", "1",
      "https://github.com/wbthomason/packer.nvim", install_path
    })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

ensure_packer()

-- Plugin setup
require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  -- Dracula theme - excellent for 256-color terminals
  use 'dracula/vim'

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- File explorer
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  }

  -- Syntax highlighting
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }

  -- Indent guides
  use "lukas-reineke/indent-blankline.nvim"

  -- Git signs in gutter
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  }

  -- Better syntax for TODO comments
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    requires = { "nvim-lua/plenary.nvim" }
  }

  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make"
  }

end)

-- Set encoding and terminal settings
vim.opt.encoding = "utf-8"

-- Detect terminal type
local term_program = vim.fn.getenv("TERM_PROGRAM")
local is_apple_terminal = term_program == "Apple_Terminal"

-- Disable true colors for 256-color terminal compatibility
vim.opt.termguicolors = false

vim.opt.background = "dark"

-- Setup Dracula colorscheme
pcall(function()
  -- Configure Dracula for 256 colors
  vim.g.dracula_italic = 1
  vim.g.dracula_bold = 1
  vim.g.dracula_underline = 1
  vim.g.dracula_undercurl = 1
  vim.g.dracula_full_special_attrs_support = 1
  vim.g.dracula_colorterm = 0 -- Force 256 color mode
  
  vim.cmd.colorscheme "dracula"
end)

-- Safely try to load neo-tree
pcall(function()
  -- Use default colors for Neo-tree
  
  require("neo-tree").setup({
    default_component_configs = {
      icon = {
        folder_closed = ">",
        folder_open = "v",
        folder_empty = ">",
        default = "*",
      },
      git_status = {
        symbols = {
          -- Change type
          added     = "+",
          deleted   = "-",
          modified  = "M",
          renamed   = "R",
          -- Status type
          untracked = "U",
          ignored   = "I",
          unstaged  = "!",
          staged    = "*",
          conflict  = "C",
        }
      },
    },
    window = {
      width = 30,
      mappings = {
        ["<space>"] = "toggle_node",
        ["<cr>"] = "open",
        ["<esc>"] = "revert_preview",
        ["P"] = { "toggle_preview", config = { use_float = true } },
      }
    },
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      use_libuv_file_watcher = true,
      hijack_netrw_behavior = "open_default",
    }
  })
end)

vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>")

-- Safely configure treesitter
pcall(function()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = { 
      "typescript",
      "javascript", 
      "tsx",
      "swift",
      "lua",
      "vim",
      "bash",
      "json",
      "yaml",
      "html",
      "css",
      "markdown",
      "markdown_inline"
    },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true
    }
  }
end)

-- Telescope configuration
pcall(function()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  
  telescope.setup {
    defaults = {
      prompt_prefix = "> ",
      selection_caret = "> ",
      path_display = {"truncate"},
      file_ignore_patterns = {
        "node_modules",
        ".git/",
        "dist/",
        "build/"
      },
      layout_config = {
        horizontal = {
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-c>"] = actions.close,
          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,
        },
        n = {
          ["<esc>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,
          ["q"] = actions.close,
        }
      }
    },
    pickers = {
      find_files = {
        theme = "dropdown",
        previewer = false,
        hidden = true,
      },
      live_grep = {
        theme = "ivy",
      },
      buffers = {
        theme = "dropdown",
        previewer = false,
        initial_mode = "normal",
      }
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      }
    }
  }
  
  -- Load fzf extension
  telescope.load_extension('fzf')
end)

-- Telescope keybindings
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'Help tags' })
vim.keymap.set('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>', { desc = 'Recent files' })
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope git_status<cr>', { desc = 'Git status' })
vim.keymap.set('n', '<leader>fc', '<cmd>Telescope git_commits<cr>', { desc = 'Git commits' })
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', { desc = 'Diagnostics' })
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope registers<cr>', { desc = 'Registers' })
vim.keymap.set('n', '<leader>fk', '<cmd>Telescope keymaps<cr>', { desc = 'Keymaps' })

-- Lualine configuration (status line)
pcall(function()
  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'dracula',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }
end)

-- Indent blankline configuration
pcall(function()
  require("ibl").setup {
    indent = {
      char = "|",
      tab_char = "|",
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = false,
      injected_languages = false,
      highlight = { "Function", "Label" },
      priority = 500,
    },
    exclude = {
      filetypes = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
      },
      buftypes = {
        "terminal",
        "nofile",
      },
    },
  }
end)

-- Gitsigns configuration
pcall(function()
  require('gitsigns').setup {
    signs = {
      add          = { text = '+' },
      change       = { text = '~' },
      delete       = { text = '-' },
      topdelete    = { text = '-' },
      changedelete = { text = '~' },
      untracked    = { text = '?' },
    },
    signcolumn = true,
    numhl      = false,
    linehl     = false,
    word_diff  = false,
    watch_gitdir = {
      interval = 1000,
      follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 1000,
      ignore_whitespace = false,
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },
  }
end)

-- TODO comments configuration
pcall(function()
  require("todo-comments").setup {
    signs = true,
    sign_priority = 8,
    keywords = {
      FIX = {
        icon = " ",
        color = "error",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    gui_style = {
      fg = "NONE",
      bg = "BOLD",
    },
    merge_keywords = true,
    highlight = {
      multiline = true,
      multiline_pattern = "^.",
      multiline_context = 10,
      before = "",
      keyword = "wide",
      after = "fg",
      pattern = [[.*<(KEYWORDS)\s*:]],
      comments_only = true,
      max_line_len = 400,
      exclude = {},
    },
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
      info = { "DiagnosticInfo", "#2563EB" },
      hint = { "DiagnosticHint", "#10B981" },
      default = { "Identifier", "#7C3AED" },
      test = { "Identifier", "#FF00FF" }
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      pattern = [[\b(KEYWORDS):]],
    },
  }
end)

-- Basic editor settings for visual appeal
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.list = true
vim.opt.listchars = { tab = '> ', trail = '·', extends = '>', precedes = '<' }

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
