# Overview
A simple demo on how to use PowerShell with Azure Functions 

# Setup 
1. az login 
2. az group create -n PowerShell_AZ_RG -l southcentralus
3. az storage account create --name bjdpssa001 --location southcentralus --resource-group PowerShell_AZ_RG --sku Standard_LRS
4. az functionapp create --name bjdps001 --storage-account bjdpssa001 --consumption-plan-location southcentralus --resource-group PowerShell_AZ_RG
5. az functionapp identity assign --name bjdps001 --resource-group PowerShell_AZ_RG
6. $functionAppId=(az functionapp identity show --name bjdps001 --resource-group PowerShell_AZ_RG --query 'principalId' --output tsv)

## Ceate Storage and Containers 
1. az storage account create --name bjdlake002 --location southcentralus --resource-group PowerShell_AZ_RG --sku Standard_LRS
2. $key=(az storage account keys list -n bjdlake002 --query "[0].value" -o tsv)
3. az storage container create --name data --account-key $key --account-name bjdlake002

## Assign Permissions
1. az role assignment create --assignee-object-id $functionAppId --role "Storage Blob Data Contributor" -g PowerShell_AZ_RG
2. az role assignment create --assignee-object-id $functionAppId --role "Reader" -g PowerShell_AZ_RG

# Publish Code
1. cd src
2. func azure functionapp publish bjdps001