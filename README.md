# nvim-hypr-anywhere

![showcase](assets/showcase.gif)

Edit text anywhere on **Wayland** using **Neovim**, then paste it into any text field via **`wtype`** or the system clipboard.  

This tool is inspired by [vim-anywhere](https://github.com/cknadler/vim-anywhere), but designed specifically for **Neovim** + **Hyprland**.

---

## Features

- Launch a temporary **Neovim** buffer from anywhere.
- Automatically paste edited text back into the currently focused text field.
- Supports optional file extensions for syntax highlighting.
- Can work in two modes:
  - **Clipboard Mode (default)** → Uses `wl-copy` + `hyprctl` to paste.
  - **Wtype Mode (`--wtype-mode`)** → Sends keystrokes directly using `wtype` (useful when clipboard-based paste doesn’t work in certain apps).
- Edits the currently selected text if any (Only in Clipboard Mode)
- Cleans up temporary files automatically if requested.

---

## Installation

```bash
git clone https://github.com/abdullah-albanna/nvim-hypr-anywhere.git
cd nvim-hypr-anywhere
chmod +x nvim-hypr-anywhere.sh
```

---

## Usage

Bind the script to a Hyprland key combination (example below with `SUPER+N`):

```bash
bind = SUPER, N, exec, uwsm app -- /path/to/nvim-hypr-anywhere.sh --font-size 25
```

---

## Command-line Options

- `--ask-ext`  
  Prompt for a file extension when creating the temporary buffer. Useful if you want syntax highlighting in Neovim (`.py`, `.rs`, `.md`, etc.).
  
- `--rm-tmp`  
  Automatically delete the temporary file after use instead of leaving it in `/tmp/nvim-hypr-anywhere`.

- `--copy-selected`
  Copy the currently selected text with Ctrl + C and start editing it

- `--wtype-mode`  
  Switches from clipboard-paste to **direct keystroke mode** using `wtype`.  
  - Useful in cases where pasting is blocked, unreliable, or when working inside apps that don’t accept clipboard input. (e.g: a Terminal; because they take a CTRL+SHIFT+V)
  - Limitation:
    - Line breaks are not yet handled perfectly (Shift+Enter support is TODO).
    - Slower, since it needs to send keystrokes

- `--font-size <size>`  
  Set the terminal font size (default: `25`).

- `--term <terminal>`  
  Choose which terminal emulator to launch Neovim in (default: `alacritty`).

- `--term-opts <opts>`  
  override terminal options (e.g. window size, class, etc.).  

---

## Hyprland Window Rules (Optional)

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
