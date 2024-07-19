# Install

```bash
git clone git@github.com:DanKruger/nvim.git ~/.config/nvim
cd ~/.config/nvim && nvim
```

# Keybinds

## Git

| Keybind           | Action       |
| ----------------- | ------------ |
| `space -> l -> g` | Open LazyGit |

## Telescope

| Keybind           | Action           |
| ----------------- | ---------------- |
| `ctrl + p`        | Fuzzy Find Files |
| `space -> f -> g` | Live grep        |
| `g -> r`          | Find references  |
| `space -> w`      | Save file        |

## Tab navigation

| Keybind    | Action                     |
| ---------- | -------------------------- |
| `ctrl + j` | Switch to tab on left      |
| `ctrl + k` | Switch to tab on the right |
| `ctrl + t` | Create new tab             |
| `ctrl + x` | Close current tab          |

## Window management

| Keybind      | Action                        |
| ------------ | ----------------------------- |
| `space -> k` | Create new window on the side |
| `space -> j` | Create new window below       |
| `space -> q` | Close window (same as :q)     |

## Window resizing

| Keybind       | Action                 |
| ------------- | ---------------------- |
| `alt + right` | Increase window width  |
| `alt + left`  | Decrease window width  |
| `alt + up`    | Increase window height |
| `alt + left`  | Decrease window height |

## Window navigation

| Keybind   | Action                        |
| --------- | ----------------------------- |
| `alt + l` | Switch to window on the right |
| `alt + h` | Switch to window on the left  |
| `alt + k` | Switch to window above        |
| `alt + j` | Switch to window below        |

## Running Code Tests

| Keybind      | Action                   |
| ------------ | ------------------------ |
| `space -> n` | Run the nearest TestCase |
| `space -> m` | Run the whole Test file  |

## Code editing

| Keybind           | Action                              |
| ----------------- | ----------------------------------- |
| `space -> g`      | Format the whole file               |
| `space -> f -> i` | Reindent whole file                 |
| `shift + i`       | Hover information on variable below |
| `ctrl + n`        | Code actions                        |
| `ctrl + e`        | Show completions                    |

## Commenting

Insert Mode

| Keybind               | Action                     |
| --------------------- | -------------------------- |
| `g -> c -> c`         | Comment whole line         |
| `g -> b -> c`         | Block comment whole line   |
| `g -> c -> shift + a` | Add comment to end of line |
| `g -> c -> 0`         | Add comment to line above  |
| `g -> c -> o`         | Add comment to line below  |

Visual Mode

| Keybind  | Action                       |
| -------- | ---------------------------- |
| `g -> c` | Comment all selected lines   |
| `g -> b` | Block comment selected lines |

## File tree

| Keybind    | Action                       |
| ---------- | ---------------------------- |
| `ctrl + e` | Open file tree on the left  |
