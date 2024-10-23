echo "Enter devhub alias"
read DEVHUB

echo "enter duration days"
read DURATION

echo "Creating Scratch Org..."
sf org create scratch --target-dev-hub $DEVHUB -a myScratchOrg --definition-file config/project-scratch-def.json --set-default --duration-days $DURATION

echo "deploying to scratch org..."
sf project deploy start  --source-dir force-app --target-org myScratchOrg --test-level NoTestRun