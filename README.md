# 🚀 Dotfiles & Server Setup

A lightweight, distro-aware configuration for fresh Linux environments. This repo automates the setup of my preferred shell environment on Fedora, Ubuntu, and Debian.

## ✨ Features
- Distro Detection: Automatically handles `dnf` or `dnf` based on the OS.
- Incremental Aliases: Downloads shared aliases to `~/.bash_aliases_git` and sources them without overwriting your existing local aliases.
- Starship Prompt: Installs and configures the [Starship](https://starship.rs/) prompt.
- Safety First: Backs up existing `starship.toml configs if changes are detected instead of overwriting them.

---

## ⚡ Quick Install

On a fresh VM or server, run the following command:
Bash

```
curl -sSL https://raw.githubusercontent.com/Godh3x/dotfiles/main/install.sh | bash
```
   **Note:** After installation, run source ~/.bashrc or restart your terminal to see the changes.

---

## 🔡 Local Font Setup (Required for Icons)

The Starship prompt uses symbols that require a **Nerd Font**. Since the font is rendered by your local terminal, install it on your workstation:

1. Download & Install (Fedora):
```bash
    mkdir -p ~/.local/share/fonts
    curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
    unzip FiraCode.zip -d ~/.local/share/fonts
    fc-cache -fv
    rm FiraCode.zip
```
2. Terminal Config: Set your Terminal font to `FiraCode Nerd Font Mono.

----

## 🛠️ Customization

### Adding new Aliases

Simply edit the `aliases` file in this repo and push to GitHub. On any machine where you've run the setup, just re-run the install command to sync the latest shortcuts.

--- 

## 🛡️ Security Note

Always be cautious when piping scripts from the internet into `bash`. This script is intended for my personal use; feel free to audit `install.sh` before running.
