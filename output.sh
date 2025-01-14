# Installation concluded, copy these values and store them, you'll use them later in this exercise:
# -> Resource Group Name: mslearn-gh-pipelines-25577
# -> ACR Name: contosocontainerregistry22474
# -> ACR Login Username: contosocontainerregistry22474
# -> ACR Password: d1XyNT0QDUEhdoo/a3ZFb7aq4yirUI6wYpDME9xG9D+ACRDXJZWo
# -> AKS Cluster Name: contosocontainerregistry22474
# -> AKS DNS Zone Name: 0ec34395126c441c8c8b.eastus.aksapp.io
# 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
# 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


# To get your DNS zone name, run this Azure CLI query: 
az aks show -g {resource-group-name} -n {aks-cluster-name} -o tsv --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName
# 0ec34395126c441c8c8b.eastus.aksapp.io

az aks list -o tsv --query "[?name=='contoso-video'].resourceGroup"

# Get a secret
az ad sp create-for-rbac --role Contributor --scopes /subscriptions/cdf131cb-448a-4d1c-b8cd-4795e14ddc1a --sdk-auth

az account list-locations \
  --query "[].{Name: name, DisplayName: displayName}" \
  --output table

az configure --defaults location=europe

resourceSuffix=$RANDOM

aksVersion=$(az aks get-versions \
  --query 'orchestrators[-1].orchestratorVersion' \
  --output tsv)

  az group create --name $rgName

  az acr create \
  --name $registryName \
  --resource-group $rgName \
  --sku Standard

  az aks create \
  --name $aksName \
  --resource-group $rgName \
  --enable-addons monitoring \
  --kubernetes-version $aksVersion \
  --generate-ssh-keys

  az provider list --query "[?namespace=='Microsoft.OperationsManagement']" --output table

  clientId=$(az aks show \
  --resource-group $rgName \
  --name $aksName \
  --query "identityProfile.kubeletidentity.clientId" \
  --output tsv)

  acrId=$(az acr show \
  --name $registryName \
  --resource-group $rgName \
  --query "id" \
  --output tsv)

  az acr list \
 --resource-group $rgName \
 --query "[].{loginServer: loginServer}" \
 --output table
#  LoginServer
# ---------------------------------
# tailspinspacegame18891.azurecr.io

# Command to create a role assignment to authorize the AKS cluster to connect to the Azure Container Registry
az role assignment create \
  --assignee $clientId \
  --role AcrPull \
  --scope $acrId

