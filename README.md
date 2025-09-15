# nvim-wl-anywhere

![showcase](assets/showcase.gif)

Edit text anywhere on **Wayland** using **Neovim**, then paste it into any text field via **`wtype`**

This tool is inspired by [vim-anywhere](https://github.com/cknadler/vim-anywhere), but designed specifically for **Neovim** + **Wayland**.

---

## Features

- Launch a temporary **Neovim** buffer from anywhere.
- Automatically paste edited text back into the currently focused text field.
- Supports optional file extensions for syntax highlighting.
- Can work in two modes:
  - **Clipboard Mode (default)** → Ctrl + v to paste.
  - **Keystroke Mode (`--keystroke-mode`)** → Sends keystrokes directly using `wtype` (useful when clipboard-based paste doesn’t work in certain apps).
- Edits the currently selected text if any (with `--copy-selected`)
- Cleans up temporary files automatically if requested.

---

## Installation

```bash
git clone https://github.com/abdullah-albanna/nvim-hypr-anywhere.git
cd nvim-hypr-anywhere
chmod +x nvim-hypr-anywhere.sh
```

---

## Configuration

### Hyprland

Bind the script to a Hyprland key combination (example below with `SUPER+N`):

```bash
bind = SUPER, N, exec, /path/to/nvim-hypr-anywhere.sh
```

---

#### Window Rules (Optional)

For a smoother workflow, add window rules to make the editor float and stay focused:

```bash
windowrulev2 = float, class:nvim-hypr-anywhere
windowrulev2 = pin, class:nvim-hypr-anywhere
windowrulev2 = stayfocused, class:nvim-hypr-anywhere
windowrulev2 = size 70% 70%, class:nvim-hypr-anywhere
```

---

## Dependencies

The script depends on the following commands:

- `nvim` → Neovim editor  
- `alacritty` → terminal (or another terminal of your choice)  
- `wofi` → for selecting a file extension when `--ask-ext` is enabled  
- `wtype` → for simulating keystrokes (needed for `--wtype-mode`)  
- `wl-clipboard` → provides `wl-copy` / `wl-paste` for clipboard support  

Install on Arch-based systems:

```bash
sudo pacman -S neovim alacritty wofi wtype wl-clipboard
```

---

## License

MIT
