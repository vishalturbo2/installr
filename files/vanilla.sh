#!/bin/bash -e
clear
echo "============================================"
echo "============================================"
echo "wordpress installation script by Team Codeskulls"
echo "============================================"
echo "============================================"
apt-get update
echo "installing apache"
sudo apt -y install apache2
echo "installing php modules"
add-apt-repository ppa:ondrej/php
apt-get update
apt-get upgrade
apt-get install php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-cli php7.0-cgi php7.0-gd
echo "installing mysql"
sudo apt-get install mysql-client mysql-server


echo "Please enter root user MySQL password!"
read rootpasswd
echo "Please enter the NAME of the new vanilla database! (example: database1)"
read dbname
echo "Please enter the WordPress database CHARACTER SET! (example: latin1, utf8, ...)"
read charset
echo "Creating new vanilla database..."
mysql -uroot -p${rootpasswd} -e "CREATE DATABASE ${dbname} /*\!40100 DEFAULT CHARACTER SET ${charset} */;"
echo "Database successfully created!"
echo "Showing existing databases..."
mysql -uroot -p${rootpasswd} -e "show databases;"
echo ""
echo "Please enter the NAME of the new vanilla database user! (example: user1)"
read username
echo "Please enter the PASSWORD for the new vanilla database user!"
read userpass
echo "Creating new user..."
mysql -uroot -p${rootpasswd} -e "CREATE USER ${username}@localhost IDENTIFIED BY '${userpass}';"
echo "User successfully created!"
echo ""
echo "Granting ALL privileges on ${dbname} to ${username}!"
mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON ${dbname}.* TO '${username}'@'localhost';"
mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"
echo "You're good now :)"

echo "============================================"
echo "vanilla Install Script"
echo "============================================"
echo "run install? (y/n)"
read -e run
if [ "$run" == n ] ; then
exit
else
echo "============================================"
echo "A robot is now installing vanilla for you."
echo "============================================"

echo "downloading vanilla forum"
wget https://open.vanillaforums.com/get/vanilla-core.zip
echo "installing unzip"
sudo unzip vanilla-core.zip -d /var/www/html/vanilla/
echo "assiging permisssions"
chown -R www-data:www-data /var/www/html/vanilla/
chmod -R 755 /var/www/html/vanilla/

echo "configuring apache"
#configuring apache
cd /etc/apache2/sites-available
#replacing root directory
replace "/var/www/html" "/var/www/html/vanilla" -- 000-default.conf
service apache2 restart
exit
