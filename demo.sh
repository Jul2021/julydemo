#!/bin/bash
source ./vars

# Creating Resource Group
az group create --name $resourceGroup --location $location
echo "Creating Resource Group"


existingVnet=$(az network vnet show --resource-group clidemo --name $vnetName --query "name" -o tsv)

if [ -z $existingVnet ]
then
  # Creating Virtual Network
  echo "$vnetName doesn't exist , Creating now"
  az network vnet create --name $vnetName --resource-group $resourceGroup \
                         --address-prefixes $vnetCidr
  # Creating Web Subnet
  echo "Creating Web Subnet"
  az network vnet subnet create --name $subnet1 --resource-group $resourceGroup \
                                --vnet-name $vnetName \
                                --address-prefixes $subnet1Cidr

  # Creating App Subnet
  echo "Creating App Subnet"
  az network vnet subnet create --name $subnet2 --resource-group $resourceGroup \
                                --vnet-name $vnetName \
                                --address-prefixes $subnet2Cidr

  # Creating DB Subnet
  echo "Creating DB Subnet"
  az network vnet subnet create --name $subnet3 --resource-group $resourceGroup \
                                --vnet-name $vnetName \
                                --address-prefixes $subnet3Cidr

else
  echo "$existingVnet already exists, hence going to next step"
fi

az network nsg create --resource-group $resourceGroup --name $webNsg

az network nsg rule create --resource-group $resourceGroup  --nsg-name $webNsg --name "HTTPRule" \
                           --priority 400 --source-address-prefixes '*' --destination-address-prefixes '*'  \
                           --destination-port-ranges '80' --direction Inbound --access Allow --protocol Tcp  \
                           --description "Allow Web Traffic from internet."


# Creating VM
echo "Creating VM"
az vm create --name $vmname --resource-group  $resourceGroup \
            --image UbuntuLTS --vnet-name $vnetName --subnet $subnet1 \
            --admin-user $adminuser --ssh-key-values /opt/lab/keys/id_az.pub \
            --nsg $webNsg


# Let's create a VNET

az network vnet create --resource-group $RG --location $LOCATION --address-prefixes "10.10.1.0/20"
