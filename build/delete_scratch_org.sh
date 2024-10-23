#!/bin/bash

# List existing scratch orgs
echo "Fetching existing Scratch Orgs..."
sf org list

# Prompt user to select a Scratch Org to delete
read -p "Enter the alias of the Scratch Org you want to delete: " org_alias

echo "Deleting Scratch Org: $org_alias..."
sf org delete scratch -o "$org_alias" -p

echo "Scratch Org $org_alias deleted successfully."
