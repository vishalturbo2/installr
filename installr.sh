#!/bin/bash -e
clear
echo "Installr by Team Codeskulls"
echo "============================================"
echo "installing automated script -Installr"
echo "usage"
echo "installr-<pacakage name>"
echo "============================================"
mkdir down
cd down
wget https://raw.githubusercontent.com/vishalturbo2/installr/master/files/wordpress.sh
chmod +x wordpress.sh
sudo ln -s ~/down/wordpress.sh /usr/bin/installr-wordpress

wget https://raw.githubusercontent.com/vishalturbo2/installr/master/files/docker.sh
chmod +x docker.sh
sudo ln -s ~/down/docker.sh /usr/bin/installr-docker

wget https://raw.githubusercontent.com/vishalturbo2/installr/master/files/jenkins.sh
chmod +x jenkins.sh
sudo ln -s ~/down/jenkins.sh /usr/bin/installr-jenkins

echo "Installed successfully"
exit
