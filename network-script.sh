#!/bin/bash

MyResourceGroup=$1
MyVnet=$2
MySubnet0=$3
MySubnet1=$4
MySubnet2=$5
MySubnet3=$6
MyNsg1=$7
MyNsg2=$8


az group create --location southcentralus --name $MyResourceGroup

az network nsg create -g $MyResourceGroup -n $MyNsg1

az network nsg create -g $MyResourceGroup -n $MyNsg2

az network vnet create -g $MyResourceGroup -n $MyVnet --address-prefix 10.0.0.0/24 
                            

az network vnet subnet create -g $MyResourceGroup --vnet-name $MyVnet -n $MySubnet0 \
                            --address-prefixes 10.0.0.0/26 --network-security-group $MyNsg1                           

az network vnet subnet create -g $MyResourceGroup --vnet-name $MyVnet -n $MySubnet1 \
                            --address-prefixes 10.0.0.64/26 --network-security-group $MyNsg1

az network vnet subnet create -g $MyResourceGroup --vnet-name $MyVnet -n $MySubnet2 \
                            --address-prefixes 10.0.0.128/26 --network-security-group $MyNsg2

az network vnet subnet create -g $MyResourceGroup --vnet-name $MyVnet -n $MySubnet3 \
                            --address-prefixes 10.0.0.192/26 --network-security-group $MyNsg2


az network nsg rule create -g $MyResourceGroup  -n In_bound --nsg-name $MyNsg1 --priority 100 \
                            --direction Inbound --source-address-prefixes 0.0.0.0/1 --source-port-ranges 22 80 443 \
                            --destination-address-prefixes 10.0.0.0/26 --destination-port-ranges 22 80 443 --access Allow --protocol Tcp 


az network nsg rule create -g $MyResourceGroup -n Out_bound --nsg-name $MyNsg1  --priority 100 \
                           --direction Outbound --source-address-prefixes VirtualNetwork --source-port-ranges '*' \
                           --destination-address-prefixes '*' --destination-port-ranges '*'  --access Allow --protocol Tcp 


az network nsg rule create -g $MyResourceGroup -n In_bound --nsg-name $MyNsg2  --priority 100 \
                           --direction Inbound --source-address-prefixes 10.0.0.0/26 --source-port-ranges '*' \
                           --destination-address-prefixes '*' --destination-port-ranges '*'  --access Allow --protocol Tcp 


az network nsg rule create -g $MyResourceGroup -n Out_bound --nsg-name $MyNsg2 --priority 100 \
                           --direction Outbound --source-address-prefixes 10.0.0.64/26 --source-port-ranges '*' \
                           --destination-address-prefixes '*' --destination-port-ranges 80 443 --access Allow --protocol Tcp 

# az network nsg rule delete -g $MyResourceGroup --nsg-name $MyNsg1 -n Out_bound
# az network nsg rule delete -g $MyResourceGroup --nsg-name $MyNsg2 -n In_bound
# az network nsg rule delete -g $MyResourceGroup --nsg-name $MyNsg1 -n In_bound
# az network nsg rule delete -g $MyResourceGroup --nsg-name $MyNsg2 -n Out_bound

# az network vnet subnet delete -g $MyResourceGroup -n $MySubnet0
# az network vnet subnet delete -g $MyResourceGroup -n $MySubnet1
# az network vnet subnet delete -g $MyResourceGroup -n $MySubnet2
# az network vnet subnet delete -g $MyResourceGroup -n $MySubnet3

# az network vnet delete -g $MyResourceGroup -n $myVNet

# az network nsg delete -g $MyResourceGroup -n $MyNsg1
# az network nsg delete -g $MyResourceGroup -n $MyNsg2

# az group delete --name $MyResourceGroup