#!/bin/bash

resourcegroup=$1
storageName=$2
containerName=$3

az group create -n $resourcegroup -l southcentralus

az storage account create --name $storageName \
--location southcentralus --resource-group $resourcegroup \
--sku Standard_LRS --kind blobstorage --access-tier hot

blobStorageAccountKey=$(az storage account keys list -g $resourcegroup \
-n $storageName --query [0].value --output tsv)

az storage container create -n $containerName --account-name $storageName \
--account-key $blobStorageAccountKey --public-access container 

# az storage container delete --name $containerName

# az storage account delete -n $storageName -g $resourcegroup

# az group delete -n $resourcegroup 