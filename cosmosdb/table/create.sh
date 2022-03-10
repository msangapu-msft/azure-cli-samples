#!/bin/bash
# Passed validation in Cloud Shell on 2/20/2022

# <FullScript>
# Create a Table API table

# Variable block
let "randomIdentifier=$RANDOM*$RANDOM"
location="East US"
failoverLocation="South Central US"
resourceGroup="msdocs-cosmosdb-rg-$randomIdentifier"
tags="create-table-cosmosdb"
account="msdocs-account-cosmos-$randomIdentifier" #needs to be lower case
table="msdocs-table-cosmos-$randomIdentifier"

# Create a resource group
echo "Creating $resourceGroup in $location..."
az group create --name $resourceGroup --location "$location" --tag $tag

# Create a Cosmos account for Table API
echo "Creating $account"
az cosmosdb create --name $account --resource-group $resourceGroup --capabilities EnableTable --default-consistency-level Eventual --locations regionName="$location" failoverPriority=0 isZoneRedundant=False --locations regionName="$failoverLocation" failoverPriority=1 isZoneRedundant=False

# Create a Table API Table
echo "Creating $table"
az cosmosdb table create --account-name $account --resource-group $resourceGroup --name $table --throughput 400
# </FullScript>

# echo "Deleting all resources"
# az group delete --name $resourceGroup -y
