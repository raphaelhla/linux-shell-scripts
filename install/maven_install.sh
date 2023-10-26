#!/bin/bash
cd ~/Downloads
wget https://dlcdn.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.tar.gz
tar -zxvf apache-maven-3.9.5-bin.tar.gz
sudo mv apache-maven-3.9.5 /opt
echo "export PATH=/opt/apache-maven-3.9.5/bin:$PATH" >> ~/.bashrc
