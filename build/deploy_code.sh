#echo "Coverting source to metadata format"
#sfdx force:source:convert -d deploy_code -r force-app

echo "Deploying code to org"
sf project deploy start  --source-dir force-app --target-org DevHub --test-level RunLocalTests --results-dir test-results --coverage-formatters text-summary
