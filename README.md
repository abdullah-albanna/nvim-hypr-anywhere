# nvim-hypr-anywhere

Edit text anywhere on Wayland using Neovim, then quickly paste it into any text field via Hyprland dispatch.

**nvim-hypr-anywhere** is inspired by [vim-anywhere](https://github.com/cknadler/vim-anywhere) but built specifically for **Neovim** and **Hyprland**.

It opens a temporary **Neovim** buffer, lets you type text, and automatically copies it to the clipboard and optionally pastes it into the currently focused text field.

## Installation

- clone the repo

```bash
git clone https://github.com/abdullah-albanna/nvim-hypr-anywhere.git
cd nvim-hypr-anywhere
```

- make the script executable

```bash
chmod +x nvim-hypr-anywhere.sh
```

- bind it to a Hyprland key
  - Pick a key combination that works for you.
  - Update the script path to wherever you saved `nvim-hypr-anywhere.sh`.
  - Remove the `uwsm` if you don't use it
  - Change `alacritty` if you use something else
  - Change the font size as you like

```bash
bind = SUPER, N, exec, pkill nvim-hypr-anywhere || (uwsm app -- alacritty -o 'font.size=25' --class nvim-hypr-anywhere -e path/to/nvim-anywhere.sh && hyprctl dispatch sendshortcut "CTRL,V," )
```
