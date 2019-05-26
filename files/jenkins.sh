#!/bin/bash -e
clear
echo "============================================"
echo "============================================"
echo "jenkins installation script by Team Codeskulls"
echo "============================================"
echo "============================================"
apt-get update
echo "downloading jdk"
apt-get update
sudo apt-get install openjdk-8-jdk
echo "installing web server"
sudo apt-get install apache2
echo "adding keys"
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
echo "ainstalling jenkins"
sudo apt-get update
sudo apt-get install jenkins
ufw allow 8080
echo "jenkins installed successfully"
