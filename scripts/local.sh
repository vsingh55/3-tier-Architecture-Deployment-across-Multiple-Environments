#!/usr/bin/env bash

set -euo pipefail
# update ubuntu
sudo apt-get update 

# update NPM (Node Package Manager)
echo "[info] insatlling npm"
sudo npm install -g npm@10.7.0

# Set up and install NVM
export NVM_DIR="/opt/nodejs/.nvm"
mkdir -p "$NVM_DIR"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | NVM_DIR="$NVM_DIR" bash
# Source nvm script to load it into the current session
source "$NVM_DIR/nvm.sh"
# Install Node.js using NVM (Node Version Manager)
nvm install 21
# Post-install verification
echo "Node version:"
node -v
echo "NPM version:"
npm -v

# download and install Node.js
echo "[info] insatlling Node.js"
nvm install 21
echo "[info] insatlled Node.js"

# verifies the right Node.js version is in the environment
node -v 
# verifies the right NPM version is in the environment
npm -v 

cd ~
cd /opt
git clone https://github.com/vsingh55/YelpCamp-Deploy-Trio-Local-Container-Azure.git
cd YelpCamp-Deploy-Trio-Local-Container-Azure
git pull
cd src
npm install
touch .env
echo "CLOUDINARY_CLOUD_NAME=" >> .env
echo "CLOUDINARY_KEY=" >> .env
echo "CLOUDINARY_SECRET=" >> .env
echo "MAPBOX_TOKEN=" >> .env
echo "DB_URL=" >> .env
echo "SECRET=" >> .env
cd ..

#Run following after SSH to VM:
# export NVM_DIR="/opt/nodejs/.nvm && source "$NVM_DIR/nvm.sh"
# access Application at http://ExternalIP:3000/