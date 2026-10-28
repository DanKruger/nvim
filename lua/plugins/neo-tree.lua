return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = {
    'Neotree',
  },
  keys = {
    { '<C-e>', '<cmd>Neotree focus filesystem reveal left <CR>', desc = 'Open filesystem to the left' },
  },
  config = function()
    require('neo-tree').setup {
      -- Keep Neo-tree feeling like a polished project sidebar.
      popup_border_style = 'rounded',
      use_libuv_file_watcher = true,
      close_if_last_window = true,
      enable_diagnostics = true,
      enable_git_status = true,
      enable_modified_markers = true,
      enable_opened_markers = true,
      open_files_in_last_window = true,
      source_selector = {
        winbar = true,
        statusline = false,
        sources = {
          { source = 'filesystem' },
          { source = 'buffers' },
          { source = 'git_status' },
        },
        tabs_layout = 'equal',
        truncation_character = '…',
      },
      window = {
        position = 'left',
        width = 34,
        auto_expand_width = false,
        mappings = {
          ['<cr>'] = 'open',
          ['s'] = 'open_vsplit',
          ['S'] = 'open_split',
          ['t'] = 'open_tabnew',
          ['P'] = {
            'toggle_preview',
            config = { use_float = true },
          },
          ['l'] = 'focus_preview',
          ['R'] = 'refresh',
          ['q'] = 'close_window',
          ['?'] = 'show_help',
        },
      },
      filesystem = {
        bind_to_cwd = true,
        hijack_netrw_behavior = 'open_default',
        async_directory_scan = 'always',
        filtered_items = {
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_by_name = {
            '.DS_Store',
            'thumbs.db',
            'node_modules',
            'dist',
            'build',
            'coverage',
            'vendor',
          },
          always_show = {
            '.gitignore',
            '.env',
            '.gitlab-ci.yml',
          },
          show_hidden_count = true,
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        window = {
          mappings = {
            ['H'] = 'toggle_hidden',
            ['.'] = 'set_root',
            ['/'] = 'fuzzy_finder',
            ['[g'] = 'prev_git_modified',
            [']g'] = 'next_git_modified',
            ['<bs>'] = 'navigate_up',
          },
        },
      },
      buffers = {
        bind_to_cwd = true,
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        window = {
          mappings = {
            ['d'] = 'buffer_delete',
            ['w'] = 'open_with_window_picker',
          },
        },
      },
    }
  end,
}
