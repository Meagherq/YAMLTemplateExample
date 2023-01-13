echo "Starting YAML Example Demo Teardown"

az account set --subscription $1

echo "Deleting Demo Dev resource group"
az group delete --name "demo-rg-dev" --yes --no-wait

echo "Deleting Demo Prod resource group"
az group delete --name "demo-rg-prod" --yes --no-wait

echo "Finished tearing down resources"