return {
  'kdheepak/lazygit.nvim',
  event = { 'VeryLazy' },
  init = function()
    -- Make LazyGit feel like the rest of the Deep Ocean UI.
    vim.g.lazygit_floating_window_scaling_factor = 0.92
    vim.g.lazygit_floating_window_winblend = 0
    vim.g.lazygit_floating_window_use_plenary = 1
    vim.g.lazygit_floating_window_border_chars = {
      '╭', '─', '╮', '│', '╯', '─', '╰', '│',
    }
    vim.g.lazygit_on_exit_callback = function()
      vim.schedule(function()
        vim.cmd('silent! checktime')
        pcall(function()
          require('gitsigns').refresh_all()
        end)
        pcall(function()
          require('neo-tree.sources.manager').refresh('filesystem')
        end)
      end)
    end
  end,
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>lg', '<cmd>LazyGit<CR>', desc = 'Open Lazy Git' },
    { '<leader>lG', '<cmd>LazyGitCurrentFile<CR>', desc = 'LazyGit for current project' },
    { '<leader>lf', '<cmd>LazyGitFilter<CR>', desc = 'LazyGit project commits' },
    { '<leader>lF', '<cmd>LazyGitFilterCurrentFile<CR>', desc = 'LazyGit current-file commits' },
    { '<leader>lc', '<cmd>LazyGitConfig<CR>', desc = 'Edit LazyGit config' },
  },
}
