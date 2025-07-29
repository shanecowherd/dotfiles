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

  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
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
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Use default colorscheme
pcall(function()
  vim.cmd.colorscheme "default"
end)

-- Safely try to load neo-tree
pcall(function()
  require("neo-tree").setup({
    default_component_configs = {
      icon = {
        folder_closed = "▸",
        folder_open = "▾",
        folder_empty = "▸",
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
      prompt_prefix = "🔍 ",
      selection_caret = "▶ ",
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
