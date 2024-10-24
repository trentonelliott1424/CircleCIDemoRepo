#!/bin/bash

# Variables
OUTPUT_DIR="deployment"  # Directory for output files
DESTRUCTIVE_FILE="$OUTPUT_DIR/destructiveChanges.xml"
PACKAGE_FILE="$OUTPUT_DIR/package.xml"
METADATA_VERSION="58.0"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Step 1: Compare the latest commit (HEAD) with the previous commit (HEAD~1) to find deleted files
echo "Comparing the latest commit with the previous commit..."
DELETED_FILES=$(git diff --name-status HEAD~1 HEAD | grep "^D" | awk '{print $2}')

# If no deleted files, exit
if [ -z "$DELETED_FILES" ]; then
  echo "No components to delete."
  exit 0
fi

# Step 2: Create destructiveChanges.xml
echo "Generating destructiveChanges.xml..."
cat <<EOF > "$DESTRUCTIVE_FILE"
<?xml version="1.0" encoding="UTF-8"?>
<Package xmlns="http://soap.sforce.com/2006/04/metadata">
EOF

# Loop over deleted files and add them to destructiveChanges.xml
for FILE in $DELETED_FILES; do
  COMPONENT_NAME=$(basename "$FILE" | sed 's/\.[^.]*$//')  # Extract component name (without extension)
  COMPONENT_TYPE=$(basename "$(dirname "$FILE")")  # Use parent directory as component type

  # Add to destructiveChanges.xml
  cat <<EOF >> "$DESTRUCTIVE_FILE"
  <types>
    <members>$COMPONENT_NAME</members>
    <name>$COMPONENT_TYPE</name>
  </types>
EOF
done

# Close the destructiveChanges.xml
cat <<EOF >> "$DESTRUCTIVE_FILE"
  <version>$METADATA_VERSION</version>
</Package>
EOF

# Step 3: Create package.xml (blank since we're only deleting)
echo "Generating package.xml..."
cat <<EOF > "$PACKAGE_FILE"
<?xml version="1.0" encoding="UTF-8"?>
<Package xmlns="http://soap.sforce.com/2006/04/metadata">
  <version>$METADATA_VERSION</version>
</Package>
EOF

# Step 4: Deploy destructive changes using Salesforce CLI
echo "Deploying destructive changes..."
sfdx force:source:deploy -x "$PACKAGE_FILE" -x "$DESTRUCTIVE_FILE"

# Check if the deployment was successful
if [ $? -eq 0 ]; then
  echo "Deployment successful!"
else
  echo "Deployment failed."
fi