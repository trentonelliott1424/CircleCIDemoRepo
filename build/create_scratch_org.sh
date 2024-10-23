#!/bin/bash

# Get the current branch name
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD | sed 's/feature\///')

echo "Enter devhub alias"
read DEVHUB

echo "enter duration days"
read DURATION

echo "Creating Scratch Org with alias $BRANCH_NAME..."
sf org create scratch --target-dev-hub $DEVHUB -a $BRANCH_NAME --definition-file config/project-scratch-def.json --set-default --duration-days $DURATION

echo "Deploying to scratch org..."
sf project deploy start --source-dir force-app --target-org $BRANCH_NAME --test-level NoTestRun

echo "Opening scratch org in chrome..."
sf org open -b chrome --target-org $BRANCH_NAME