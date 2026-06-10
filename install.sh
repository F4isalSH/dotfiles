#!/usr/bin/env bash

# Stop the script immediately if any command fails, if an undefined variable
# is used, or if a command in a pipeline fails.
set -euo pipefail

# Figure out the full path to where this script lives (i.e. your dotfiles folder).
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# The first argument you pass is where symlinks will be created.
# If you don't pass anything, it defaults to ~/.config
# Usage: ./install.sh           -> links to ~/.config
#        ./install.sh ~/mydir   -> links to ~/mydir
TARGET_DIR="${1:-$HOME/.config}"

# Create the target directory if it doesn't already exist.
mkdir -p "$TARGET_DIR"

# Loop through every folder inside the dotfiles directory.
# Each folder (nvim, tmux, alacritty, etc.) will become a symlink in the target.
for dir in "$DOTFILES_DIR"/*/; do

    # Get just the folder name (e.g. "nvim" from "/path/to/dotfiles/nvim/").
    name="$(basename "$dir")"

    # Skip the .git folder -- that's not a config, it's version control data.
    [ "$name" = ".git" ] && continue

    # This is where the symlink will be created (e.g. ~/.config/nvim).
    target="$TARGET_DIR/$name"

    # If a symlink already exists at that location, remove it so we can
    # create a fresh one pointing to the current dotfiles.
    if [ -L "$target" ]; then
        echo "removing old symlink: $target"
        rm "$target"

    # If a real folder/file (not a symlink) exists, rename it to .bak
    # so nothing is lost.
    elif [ -e "$target" ]; then
        echo "backing up existing $target -> ${target}.bak"
        mv "$target" "${target}.bak"
    fi

    # Create a symbolic link: target -> dotfiles folder.
    # This means programs looking at e.g. ~/.config/nvim will actually
    # read from your dotfiles repo.
    ln -s "$dir" "$target"
    echo "linked: $target -> $dir"
done

echo "done! all configs linked to $TARGET_DIR"
