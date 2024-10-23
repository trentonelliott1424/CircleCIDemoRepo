#!/bin/bash

# Extract the commit message
COMMIT_MESSAGE=$(git log -1 --pretty=%B)

# Check if the commit message contains the keyword
if echo "$COMMIT_MESSAGE" | grep -q "KEYWORD"; then
  echo "Keyword found in commit message."
  exit 0  # Exit with 0, indicating success (keyword found)
else
  echo "Keyword not found in commit message."
  exit 1  # Exit with 1, indicating failure (keyword not found)
fi