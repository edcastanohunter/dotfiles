#!/bin/bash

# Check for correct usage
if [ "$#" -ne 1]; then 
    echo "Usage: $0 <base_directory>"
    exit 1
fi

# base_dir="mnt/c/_SB"
# Assign command-line arguments to variables
base_dir="$1"

# Loop through each directory in the base directory
for dir in "$base_dir"/*; do
    if [ -d "$dir" ]; then # Check if it's a directory
        echo "Processing $dir"

        # Zip the directory
        zip -r "$base_dir/$(basename "$dir").zip" "$base_dir/$(basename "$dir")"

        echo "Created $(basename "$dir").zip in $base_dir"
    fi
done

echo "All directories zipped."