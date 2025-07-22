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

  -- Color scheme
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        term_colors = true,
        integrations = {
          neotree = true,
          treesitter = true,
        }
      })
    end
  }
end)

-- Set encoding and terminal settings
vim.opt.encoding = "utf-8"
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Set color scheme (safely)
pcall(function()
  vim.cmd.colorscheme "catppuccin"
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
