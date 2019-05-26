#!/bin/bash
resourcegroup=$1
vmname=$2


#Checking group exists or not through if condition 
if [ "$( az group exists --name $resourcegroup )" = "false" ]; then
  az group create -n $resourcegroup -l southcentralus
fi


#VM Creation
az vm create -g $resourcegroup -n $vmname --image UbuntuLTS  --size standard_B1s  --admin-username nagarjuna


# #VM Deletion
# az vm delete -g $resourcegroup -n $vmname --yes 