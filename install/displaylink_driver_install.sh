#!bin/bash
cd ~/Downloads
wget https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb
sudo apt install ~/Downloads/synaptics-repository-keyring.deb
sudo apt update
sudo apt install displaylink-driver -y
