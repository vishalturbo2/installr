
#!/bin/bash -e
clear
echo "============================================"
echo "============================================"
echo "docker installation script by Team Codeskulls"
echo "============================================"
echo "============================================"
apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
echo "adding key"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "adding repository"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
echo "updating"
sudo apt-get update
echo "installing docker"
sudo apt-get install -y docker-ce
echo "testing docker"
docker run hello-world
exit
