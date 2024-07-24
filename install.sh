#!/usr/bin/env bash

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="${SCRIPT_DIR}/home"
BACKUP_DIR="${SCRIPT_DIR}/backup"

# Function to create symlinks and backup existing files
create_symlinks() {
  local src_dir=$1
  local dest_dir=$2

  # Iterate over all items in the source directory, including hidden ones
  for item in "$src_dir"/.*  "$src_dir"/*; do
    # Skip the current (.) and parent (..) directory
    [[ "$item" == "$src_dir/." || "$item" == "$src_dir/.." ]] && continue

    # Get the relative path
    relative_path="${item#$HOME_DIR/}"

    # Determine the destination path
    dest_path="$dest_dir/$relative_path"

    # If the item is a directory, create the directory in the destination
    if [ -d "$item" ]; then
      mkdir -p "$dest_path"
      create_symlinks "$item" "$dest_dir"
    elif [ -f "$item" ]; then
      # If the item is a file, check if it exists in the destination
      if [ -e "$dest_path" ]; then
        # If it exists, check if it's a symlink pointing to the correct location
        if [ -L "$dest_path" ] && [ "$(readlink -f "$dest_path")" = "$item" ]; then
          echo "Correct symlink already exists: $dest_path"
        else
          # If it's not a correct symlink, back it up
          backup_path="${BACKUP_DIR}${dest_path#$HOME}"
          mkdir -p "$(dirname "$backup_path")"
          mv "$dest_path" "$backup_path"
          echo "Backed up existing file: $dest_path to $backup_path"
          ln -sf "$item" "$dest_path"
          echo "Created new symlink: $dest_path"
        fi
      else
        # If it doesn't exist, create the symlink
        mkdir -p "$(dirname "$dest_path")"
        ln -sf "$item" "$dest_path"
        echo "Created new symlink: $dest_path"
      fi
    fi
  done
}

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Start the symlink creation process
create_symlinks "$HOME_DIR" "$HOME"

echo "Symlinking completed."
