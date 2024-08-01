#!/bin/bash

# Update the package list
sudo apt-get update -y

# Install Azure CLI
echo "Installing Azure CLI..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Verify Azure CLI installation
if az --version; then
    echo "Azure CLI installed successfully."
else
    echo "Failed to install Azure CLI."
    exit 1
fi

# Install kubectl
echo "Installing kubectl..."
sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo bash -c 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF'
sudo apt-get update -y
sudo apt-get install -y kubectl

# Verify kubectl installation
if kubectl version --client; then
    echo "kubectl installed successfully."
else
    echo "Failed to install kubectl."
    exit 1
fi

echo "All CLI tools installed successfully."
