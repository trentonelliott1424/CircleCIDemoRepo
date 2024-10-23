#!/bin/bash

# Run the sf project retrieve preview command
echo "Running 'sf project retrieve preview'..."
sf project retrieve preview

# Prompt the user to confirm if they want to proceed with 'sf project retrieve start'
read -p "Do you want to proceed with 'sf project retrieve start'? (y/n): " response

# Check the user's input
if [[ "$response" == "y" || "$response" == "Y" ]]; then
    echo "Running 'sf project retrieve start'..."
    sf project retrieve start
else
    echo "Operation cancelled."
fi
