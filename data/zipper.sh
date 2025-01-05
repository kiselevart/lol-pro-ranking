#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <mode> <directory>"
    echo "Modes:"
    echo "  compress   - Compress all files in the directory"
    echo "  decompress - Decompress all .gz files in the directory"
    exit 1
fi

MODE=$1
DIRECTORY=$2

# Check if the directory exists
if [ ! -d "$DIRECTORY" ]; then
    echo "Error: Directory '$DIRECTORY' does not exist."
    exit 1
fi

# Perform the selected operation
case $MODE in
    compress)
        echo "Compressing all files in '$DIRECTORY'..."
        for file in "$DIRECTORY"/*; do
            if [ -f "$file" ]; then
                gzip -k "$file" && echo "Compressed: $file"
            fi
        done
        ;;
    decompress)
        echo "Decompressing all .gz files in '$DIRECTORY'..."
        for file in "$DIRECTORY"/*.gz; do
            if [ -f "$file" ]; then
                gunzip -k "$file" && echo "Decompressed: $file"
            fi
        done
        ;;
    *)
        echo "Error: Invalid mode '$MODE'. Use 'compress' or 'decompress'."
        exit 1
        ;;
esac

echo "Operation completed."
