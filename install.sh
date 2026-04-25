#!/bin/bash
set -e

USER_NAME="Godh3x"
REPO_NAME="dotfiles"
RAW_URL="https://raw.githubusercontent.com/${USER_NAME}/${REPO_NAME}/main"

# Determine if sudo is needed
if [ "$EUID" -ne 0 ]; then
    if command -v sudo >/dev/null 2>&1; then
        SUDO="sudo"
    else
        echo "❌ Error: sudo is not installed and you are not root."
        exit 1
    fi
else
    SUDO=""
fi

echo "🔍 Detecting OS..."
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS="${ID}"
else
    echo "❌ OS detection failed." && exit 1
fi

# --- DEPENDENCIES ---
echo "📦 Installing system dependencies..."
if [[ "${OS}" == "fedora" ]]; then
    ${SUDO} dnf install -y curl git util-linux-user
elif [[ "${OS}" == "ubuntu" || "${OS}" == "debian" ]]; then
    ${SUDO} apt update && ${SUDO} apt install -y curl git
fi

# --- ALIASES ---
echo "🔗 Downloading aliases..."
curl -s "${RAW_URL}/aliases" -o ~/.bash_aliases_git

LOAD_LINE='[ -f ~/.bash_aliases_git ] && . ~/.bash_aliases_git'
if ! grep -q "bash_aliases_git" ~/.bashrc; then
    echo "🔗 Adding link to ~/.bashrc..."
    echo -e "\n# Load GitHub Shared Aliases\n${LOAD_LINE}" >> ~/.bashrc
fi

# --- STARSHIP ---
if ! command -v starship &> /dev/null; then
    echo "✨ Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

mkdir -p ~/.config
if [ -f ~/.config/starship.toml ]; then
    echo "⚙️ Configuring Starship..."
    # Only backup if the file is DIFFERENT from current version
    curl -s "${RAW_URL}/starship.toml" -o /tmp/starship_new.toml
    if ! cmp -s ~/.config/starship.toml /tmp/starship_new.toml; then
        echo "💾 Existing Starship config found. Backing up to starship.toml.bak"
        mv ~/.config/starship.toml ~/.config/starship.toml.bak
        mv /tmp/starship_new.toml ~/.config/starship.toml
    else
        echo "✅ Starship config is already up to date."
    fi
else
    echo "⚙️ Installing new Starship config..."
    curl -s "${RAW_URL}/starship.toml" -o ~/.config/starship.toml
fi

if ! grep -q 'starship init bash' ~/.bashrc; then
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi

echo "✅ Setup complete! Run: source ~/.bashrc"
