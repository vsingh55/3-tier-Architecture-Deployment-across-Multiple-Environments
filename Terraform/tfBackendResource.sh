#!/bin/bash

# Declare variable names
RESOURCE_GROUP_NAME=backend-rg
STORAGE_ACCOUNT_BASE_NAME=backendsa4tf
RANDOM_STRING=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 5 | head -n 1) # Only lowercase letters and numbers
STORAGE_ACCOUNT_NAME="${STORAGE_ACCOUNT_BASE_NAME}${RANDOM_STRING}"
CONTAINER_NAME=tfstate

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location centralindia

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Retrieve the storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query "[0].value" -o tsv)

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

echo "Storage Account Name: $STORAGE_ACCOUNT_NAME"
echo "Blob Container '$CONTAINER_NAME' created successfully."
