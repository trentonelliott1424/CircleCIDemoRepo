echo "Logging into Sandbox Salesforce Org"
mkdir keys
echo -n $SANDBOX_CERT_KEY | base64 -di > keys/server.key

echo "Authenticating org"
sf org login jwt --client-id $SANDBOX_APP_KEY --jwt-key-file keys/server.key --username $SANDBOX_USERNAME --set-default-dev-hub -a DevHub