echo "Starting YAML Example Demo Setup"

az account set --subscription $1

# Variable block
location=$2
skuStorage="Standard_LRS"
functionsVersion="4"

# Development Infrastructure

# Create a resource group
echo "Creating demo-rg-dev in "$location"..."
devResourceGroup=$(az group create --name "demo-rg-dev" --location "$location")

# Create an Azure storage account in the resource group.
echo "Creating demosadev"
devStorageAccount=$(az storage account create --name "demosadev" --location $location --resource-group "demo-rg-dev" --sku $skuStorage)

# Create a serverless function app in the resource group.
echo "Creating $functionApp"
devFunctionApp=$(az functionapp create --name "demo-func-dev" --storage-account "demosadev" --consumption-plan-location $location --resource-group "demo-rg-dev" --functions-version $functionsVersion)

devDeploymentSlot=$(az functionapp deployment slot create --name "demo-func-dev" --resource-group "demo-rg-dev" --slot "secondary-slot")

#--------------------------------------------------------------------------------------------

# Production Infrastructure

# Create a resource group
echo "Creating demo-rg-prod in $location..."
prodResourceGroup=$(az group create --name "demo-rg-prod" --location $location)

# Create an Azure Storage Account in the Resource Group.
echo "Creating demosaprod"
prodStorageAccount=$(az storage account create --name "demosaprod" --location $location --resource-group "demo-rg-prod" --sku $skuStorage)

# Create a Consumption function app in the Resource Group.
echo "Creating demo-func-prod"
prodFunctionApp=$(az functionapp create --name "demo-func-prod" --storage-account "demosaprod" --consumption-plan-location $location --resource-group "demo-rg-prod" --functions-version $functionsVersion)

# Create an App Service Deployment Slot on the Azure Function App.
echo "Creating secondary slot"
prodDeploymentSlot=$(az functionapp deployment slot create --name "demo-func-prod" --resource-group "demo-rg-prod" --slot "secondary-slot")

echo "Finished creating resources"