#!/bin/bash

# Extract the commit message
COMMIT_MESSAGE=$(git log -1 --pretty=%B)

# Check if the commit message contains the keyword
if echo "$COMMIT_MESSAGE" | grep -q "KEYWORD"; then
  echo "Keyword found in commit message."
  echo "KEYWORD_FOUND=true" >> $BASH_ENV  # Set environment variable to true
else
  echo "Keyword not found in commit message."
  echo "KEYWORD_FOUND=false" >> $BASH_ENV  # Set environment variable to false
fi