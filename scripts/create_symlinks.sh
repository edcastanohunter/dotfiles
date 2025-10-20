#!/bin/bash

# Script to create symbolic links for dotfiles
# Usage: ./create_symlinks.sh

# Exit on error
set -e

# Get the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to create a symbolic link
create_link() {
    local source=$1
    local target=$2
    
    # Check if the source file exists
    if [ ! -e "$source" ]; then
        echo -e "${RED}Source file does not exist: $source${NC}"
        return 1
    }
    
    # Backup existing file if it exists and is not a symlink
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
        echo -e "${YELLOW}Backing up existing file to: $backup${NC}"
        mv "$target" "$backup"
    fi
    
    # Remove existing symlink if it exists
    [ -L "$target" ] && rm "$target"
    
    # Create the symlink
    echo -e "${GREEN}Creating symlink: $target -> $source${NC}"
    ln -s "$source" "$target"
}

# Create necessary directories
mkdir -p ~/.config

# SSH config
echo "Setting up SSH configuration..."
mkdir -p ~/.ssh
create_link "$DOTFILES_DIR/ssh/config" ~/.ssh/config
create_link "$DOTFILES_DIR/ssh/ed_go_key" ~/.ssh/ed_go_key
create_link "$DOTFILES_DIR/ssh/ed_go_key.pub" ~/.ssh/ed_go_key.pub

# Fix SSH key permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config
chmod 600 ~/.ssh/ed_go_key
chmod 644 ~/.ssh/ed_go_key.pub

# n8n configuration
echo "Setting up n8n configuration..."
mkdir -p ~/.n8n
if [ -d "$DOTFILES_DIR/n8n" ]; then
    for file in "$DOTFILES_DIR"/n8n/*; do
        if [ -f "$file" ]; then
            create_link "$file" ~/.n8n/$(basename "$file")
        fi
    done
fi

echo -e "\n${GREEN}Symlinks created successfully!${NC}"
echo -e "${YELLOW}Note: Some files were backed up with .backup extension if they existed${NC}"