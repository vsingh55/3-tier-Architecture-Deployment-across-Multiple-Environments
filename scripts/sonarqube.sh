#!/bin/bash

# Update the package index to ensure we install the latest versions of packages
sudo apt-get update

# Install necessary packages for downloading files securely and managing certificates
sudo apt-get install -y ca-certificates curl

# Create a directory to store Docker's keyring for secure APT (Advanced Package Tool) repository access
sudo install -m 0755 -d /etc/apt/keyrings

# Download Docker's official GPG key and save it to the keyring directory
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

# Adjust permissions to ensure the Docker GPG key file is readable
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker's official APT repository to the system's software repository list
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index again to include Docker packages from the newly added repository
sudo apt-get update

# Install Docker components: Docker Engine, CLI, containerd.io (core container runtime)
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Adjust permissions for Docker socket to allow non-root users to run Docker commands
sudo chmod 666 /var/run/docker.sock

# Start a Docker container named 'sonar' running SonarQube LTS Community Edition on port 9000
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
