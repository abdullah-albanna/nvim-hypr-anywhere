# nvim-hypr-anywhere

Edit text anywhere on Wayland using Neovim, then quickly paste it into any text field via Hyprland dispatch.

**nvim-hypr-anywhere** is inspired by [vim-anywhere](https://github.com/cknadler/vim-anywhere) but built specifically for **Neovim** and **Hyprland**.

It opens a temporary **Neovim** buffer, lets you type text, then it pastes it into the currently focused text field.

## Installation

- Clone the repo

```bash
git clone https://github.com/abdullah-albanna/nvim-hypr-anywhere.git
cd nvim-hypr-anywhere
```

- Make the script executable

```bash
chmod +x nvim-hypr-anywhere.sh
```

- Bind it to a Hyprland key
  - Pick a key combination that works for you.
  - Update the script path to wherever you saved `nvim-hypr-anywhere.sh`.
  - Remove the `uwsm` if you don't use it
  - Change the font size if needed, the default is 25

```bash
bind = SUPER, N, exec, pkill nvim-hypr-anywhere || uwsm app -- /path/to/nvim-hypr-anywhere.sh 25
```

- Update the rules

This is not necessary, but it's nice

```bash
windowrulev2 = float, class:nvim-hypr-anywhere
windowrulev2 = pin, class:nvim-hypr-anywhere
windowrulev2 = stayfocused, class:nvim-hypr-anywhere
windowrulev2 = size 70% 70%, class:nvim-hypr-anywhere
```
