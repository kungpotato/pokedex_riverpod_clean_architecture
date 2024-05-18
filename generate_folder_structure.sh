#!/bin/bash

# Check if tree is installed
if ! command -v tree &> /dev/null
then
    echo "tree could not be found, please install it using 'brew install tree'"
    exit
fi

# Generate folder structure for the lib directory and save to folder_structure.txt
tree lib | tee folder_structure.txt

# Output message
echo "Folder structure saved to folder_structure.txt and printed to console"