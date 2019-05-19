#!/bin/bash -e
clear
echo "============================================"
echo "============================================"
echo "wordpress installation script by Team Codeskulls"
echo "script made for afourtech hackathon"
echo "============================================"
echo "============================================"
apt-get update
apt-get install perl
echo "installing apache server"
apt-get install apache2 apache2-utils 
cd /var/www/html
rm index.html
echo "installing php modules"
add-apt-repository ppa:ondrej/php
apt-get update
apt-get upgrade
apt-get install php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-cli php7.0-cgi php7.0-gd
echo "installing mysql"
sudo apt-get install mysql-client mysql-server
echo "now create a database for wordpress"

echo "Please enter root user MySQL password!"
read rootpasswd
echo "Please enter the NAME of the new WordPress database! (example: database1)"
read dbname
echo "Please enter the WordPress database CHARACTER SET! (example: latin1, utf8, ...)"
read charset
echo "Creating new WordPress database..."
mysql -uroot -p${rootpasswd} -e "CREATE DATABASE ${dbname} /*\!40100 DEFAULT CHARACTER SET ${charset} */;"
echo "Database successfully created!"
echo "Showing existing databases..."
mysql -uroot -p${rootpasswd} -e "show databases;"
echo ""
echo "Please enter the NAME of the new WordPress database user! (example: user1)"
read username
echo "Please enter the PASSWORD for the new WordPress database user!"
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
echo "WordPress Install Script"
echo "============================================"
echo "run install? (y/n)"
read -e run
if [ "$run" == n ] ; then
exit
else
echo "============================================"
echo "A robot is now installing WordPress for you."
echo "============================================"
#download wordpress
curl -O https://wordpress.org/latest.tar.gz
#unzip wordpress
tar -zxvf latest.tar.gz
#move wordpress to new directory
#permissions
chown -R www-data:www-data /var/www/html/wordpress/
chmod -R 755 /var/www/html/wordpress/
#create wp config
cd
cd /var/www/html/wordpress
cp wp-config-sample.php wp-config.php
#set database details with perl find and replace
perl -pi -e "s/database_name_here/$dbname/g" wp-config.php
perl -pi -e "s/username_here/$username/g" wp-config.php
perl -pi -e "s/password_here/$userpass/g" wp-config.php

#set WP salts
perl -i -pe'
  BEGIN {
    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
    push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
    sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
  }
  s/put your unique phrase here/salt()/ge
' wp-config.php

#create uploads folder and set permissions
echo "configuring apache"
#configuring apache
cd /etc/apache2/sites-available
#replacing root directory
replace "/var/www/html" "/var/www/html/wordpress" -- 000-default.conf
service apache2 restart

echo "========================="
echo "Wordpress Installation is complete."
echo "========================="
echo "your website link"
echo "Website:    https://www.$DOMAIN"
fi          
