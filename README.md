# Daniel's Neovim

A calm, fast Neovim setup built around a transparent **Deep Ocean** theme, LSP-powered editing, Telescope navigation, automatic formatting, Git tools, and a few friendly quality-of-life shortcuts.

It is designed to feel at home in Ghostty with a dark terminal background, but it also works perfectly well in any terminal that supports true colour.

## What is included

- **Deep Ocean** colours based on Ghostty's Material Ocean palette
- Transparent editor, Telescope, Navbuddy, Noice, and statusline backgrounds
- LSP support managed through Mason and `mason-lspconfig`
- Treesitter syntax highlighting, folding, and automatic parser installation
- Conform formatting on save, with a one-off format-free save command
- Telescope file, grep, Git, diagnostics, and LSP pickers
- Neo-tree and Oil file navigation
- LazyGit and Gitsigns integration
- Navbuddy symbol navigation in a full-screen layout
- nvim-dap debugging for Go, C, and C++
- Sessions, folds, completion, autopairs, comments, surround, colour picking, and Zen Mode

## Requirements

Install these first:

- Neovim 0.10 or newer
- Git
- A Nerd Font in your terminal
- Node.js and npm (needed by several language servers and Prettier)
- A C compiler (needed to build `telescope-fzf-native`)
- `fd` and `ripgrep` for fast Telescope searching
- A working Go toolchain if you use Go

On macOS with Homebrew:

```sh
brew install neovim git node fd ripgrep
```

Make sure Ghostty is using a true-colour terminal and a Nerd Font. The config sets the leader key to Space.

## Installation

Back up an existing configuration, then clone this repository into Neovim's config directory:

```sh
mv ~/.config/nvim ~/.config/nvim.backup
git clone <your-repository-url> ~/.config/nvim
nvim
```

Lazy.nvim installs the plugins on the first launch. If anything is missing, run:

```vim
:Lazy sync
:Mason
```

Restart Neovim after the first plugin installation.

## Everyday workflow

| Action                           | Shortcut    |
| -------------------------------- | ----------- |
| Find files                       | `<C-p>`     |
| Search Git-tracked files         | `<C-g>`     |
| Live grep                        | `<Space>fg` |
| Search open buffers              | `<Space>fb` |
| Search recent files              | `<Space>fr` |
| Search the word under the cursor | `<Space>fs` |
| Open file explorer               | `<C-e>`     |
| Open LazyGit                     | `<Space>lg` |
| Format the current buffer        | `<Space>g`  |
| Save without formatting          | `:wnf`      |
| Open Navbuddy                    | `<Space>nb` |
| Toggle Zen Mode                  | `<C-c>`     |
| Save a session                   | `<Space>ss` |
| Restore a session                | `<Space>sr` |

Telescope opens in Normal mode so `j` and `k` work immediately. Typing another printable character switches to Insert mode automatically. Press `<Esc>` to clear search highlights, and `jj` in Insert mode to return to Normal mode.

## LSP and code navigation

Language servers are installed automatically through Mason when they are listed in the configuration. The current setup includes:

- Lua: `lua_ls`
- JavaScript and TypeScript: `vtsls`
- Vue: `vue_ls` plus `vtsls` with the Vue TypeScript plugin
- YAML: `yamlls`
- JSON: `jsonls`
- C and C++: `clangd`
- Go: `gopls`
- Prisma: `prismals`

Mason also ensures common servers for CSS, HTML, Emmet, Astro, Bash, Python, Markdown, Java, and C/C++. Servers only attach when the current filetype and project root match.

Useful LSP shortcuts:

| Action               | Shortcut     |
| -------------------- | ------------ |
| Go to definition     | `gd`         |
| Go to declaration    | `gD`         |
| Find references      | `gr`         |
| Go to implementation | `gI`         |
| Type definition      | `<Space>D`   |
| Document symbols     | `<Space>ds`  |
| Workspace symbols    | `<Space>ws`  |
| Rename symbol        | `<C-d><C-r>` |
| Code action          | `<C-n>`      |
| LSP action menu      | `<Space>la`  |
| Open Navbuddy        | `<Space>nb`  |

Diagnostics can be navigated with `[d` and `]d`. Use `<Space>oe` to open the diagnostic under the cursor and `<Space>oq` to open the diagnostic list. `<Space>q` closes the current window.

## Formatting

Formatting runs automatically before saving when a formatter is available. You can also format manually with `<Space>g` in Normal or Visual mode.

Supported formatters include Stylua, Go tools, Clang-Format, Dart Format, Prettier/Prettierd, and Markdown tools.

To save one time without formatting:

```vim
:wnf
```

EJS uses Prettier's HTML parser and requires the project-local plugin:

```sh
npm install --save-dev prettier-plugin-ejs
```

## Git

Gitsigns shows changes in the sign column and enables these buffer-local shortcuts:

| Action                   | Shortcut     |
| ------------------------ | ------------ |
| Next/previous hunk       | `]c` / `[c`  |
| Preview hunk             | `<Space>hh`  |
| Diff current file        | `<Space>hd`  |
| Blame current line       | `<Space>hb`  |
| Toggle line blame        | `<Space>htb` |
| Toggle deleted lines     | `<Space>htd` |
| Toggle line highlighting | `<Space>htl` |
| Toggle word diff         | `<Space>htw` |

LazyGit opens with `<Space>lg`. Pull requests and GitHub/GitLab workflows remain available through the `gh` or `glab` commands inside LazyGit's terminal.

## Completion, comments, and editing helpers

| Action                          | Shortcut              |
| ------------------------------- | --------------------- |
| Trigger completion              | `<C-Space>`           |
| Next/previous completion item   | `<C-n>` / `<C-b>`     |
| Confirm completion              | `<CR>`                |
| Abort completion                | `<C-e>`               |
| Jump forward/back in a snippet  | `<C-k>` / `<C-j>`     |
| Toggle line comment             | `gcc`                 |
| Toggle block comment            | `gbc`                 |
| Comment above/below/end of line | `gcO` / `gco` / `gcA` |
| Surround text                   | `ys`, `ds`, `cs`      |
| Pick a colour                   | `:CccPick`            |

Completion is powered by nvim-cmp and LuaSnip. Autopairs integrate with completion, and mini.ai provides richer around/inside text objects.

## Extra tools

- **Dropbar:** `<Space>;` picks a symbol; `[;` and `];` move through context.
- **Trouble:** `<C-t>xx` opens diagnostics, `<C-t>cs` opens symbols, and `<C-t>cl` opens LSP results.
- **Tests:** `<Space>tt` runs the nearest test and `<Space>tf` runs the current test file.
- **Dashboard:** on startup, `e` creates a file, `f` finds a file, `S` opens Neo-tree, `r` opens recent files, and `q` quits.
- **Oil:** inside an Oil buffer, `<CR>` opens an entry, `<C-p>` previews it, `-` goes to the parent directory, `g.` toggles hidden files, and `g?` shows help.
- **Flutter/Dart:** `flutter-tools.nvim` is loaded for Dart buffers.
- **Markdown linting:** `markdownlint` runs on buffer entry, insert leave, and after saving Markdown files.

## Windows, tabs, and folds

| Action                 | Shortcut                                |
| ---------------------- | --------------------------------------- |
| Move between windows   | `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`      |
| Horizontal split       | `<Space>k`                              |
| Vertical split         | `<Space>j`                              |
| Close window           | `<Space>q`                              |
| Resize window          | `<A-Arrow>`                             |
| Previous/next tab      | `<A-j>` / `<A-k>`                       |
| New/close tab          | `<A-t>` / `<A-x>`                       |
| Toggle/open/close fold | `<Space>ff` / `<Space>fo` / `<Space>fc` |
| Open/close all folds   | `<Space>fR` / `<Space>fM`               |
| Next/previous fold     | `]f` / `[f`                             |

The arrow keys in Normal mode intentionally display a reminder to use Vim's `h`, `j`, `k`, and `l` navigation keys.

## Debugging

Mason installs the configured debug adapters for Go, C, and C++.

| Action                 | Shortcut   |
| ---------------------- | ---------- |
| Start/continue         | `<F5>`     |
| Step into              | `<F1>`     |
| Step over              | `<F2>`     |
| Step out               | `<F3>`     |
| Toggle breakpoint      | `<Space>b` |
| Conditional breakpoint | `<Space>B` |
| Toggle DAP UI          | `<F7>`     |

## Troubleshooting

### Check installed plugins and tools

```vim
:Lazy
:Mason
:ConformInfo
:checkhealth
```

### A language server does not attach

1. Confirm the filetype with `:set filetype?`.
2. Check that the project has a sensible root marker such as `.git`, `package.json`, or `tsconfig.json`.
3. Open `:Mason` and verify the server is installed.
4. Run `:LspInfo` and inspect the attached clients.

### Formatting does not run

Check `:ConformInfo`. For JavaScript, TypeScript, Vue, YAML, JSON, HTML, CSS, and EJS, make sure Node.js is installed and the project has the relevant Prettier plugin when one is required.

### Transparent backgrounds look wrong

The theme deliberately uses `NONE` backgrounds so Ghostty can show through. Ensure `termguicolors` is enabled and that your terminal is not forcing an opaque background.

## Customising the configuration

- General options: `lua/core/options.lua`
- Core mappings: `lua/core/keymaps.lua`
- Plugin specifications: `lua/plugins/`
- Theme and highlight groups: `colors/deep-ocean.lua`
- LSP and Mason setup: `lua/plugins/LSP.lua`
- Formatting: `lua/plugins/conform.lua`

After changing a plugin specification, run `:Lazy sync` and restart Neovim. After changing the theme, use `:colorscheme deep-ocean` to reload it immediately.

Have fun, keep your leader key close, and remember: `:help` is always one command away.
