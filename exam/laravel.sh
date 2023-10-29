#! /bin/bash

#STEP ONE:
git clone https://github.com/laravel/laravel
cd laravel

#STEP TWO: install php dependency (composer)
sudo apt install curl php-mbstring git unzip   php-xml  php-curl curl

#STEP THREE:INSTALL COMPOSER
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

composer install

#STEP FIVE: 
composer update

#STEP SIX:
#rename env.example to .env using this 
mv .env.example .env
php artisan key:generate

#STEP SEVEN:
#generate the php artisan key or use this link and to generate the key:
#https://generate-random.org/laravel-key-generator?count=1

#STEP EIGHT:
#edit the APP_KEY in your .env 
#vim .env

#STEP NINE:
#Start the laravel deployment server by running this command:

#STEP TEN  
#Access your laravel application by visiting this link in your web browser:
#http://localhost:8000

# disable the default apache page
echo "disable default apache page"
sudo a2dissite 000-default.conf

# navigate to sites-availble
echo "navigate to sites-availble"
cd /etc/apache2/sites-available

# check directory
echo $(pwd)

# create your site file
echo "Create sitename.conf"
sudo touch maryjane.conf

# update the content
echo "update file"
sudo sed -n 'w maryjane.conf' <<EOF
<VirtualHost *:80>
    ServerAdmin admin@admin.com
    ServerName maryjane_ubuntu@ubuntu.local

    DocumentRoot /var/www/maryjane/public

    <Directory /var/www/maryjane/public>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/maryjane-error.log
    CustomLog \${APACHE_LOG_DIR}/maryjane-access.log combined

    <IfModule mod_dir.c>
        DirectoryIndex index.php
    </IfModule>
</VirtualHost>
EOF


# enable the site
echo "enabling maryjane"
sudo a2ensite maryjane

# create the site directory
echo "create site directory"
sudo mkdir -p /var/www/maryjane

# copy the content to site directory
cd
echo $(pwd)
sudo cp -R laravel/. /var/www/maryjane/


# go back to the directory
cd /var/www/maryjane
echo $(pwd)

# set permission for the files
echo "grant permission to files"
sudo chown -R maryjane_ubuntu:www-data /var/www/maryjane/
sudo find /var/www/maryjane/ -type f -exec chmod 664 {} \;
sudo find /var/www/maryjane/ -type d -exec chmod 775 {} \;
sudo chgrp -R www-data storage bootstrap/cache
sudo chmod -R ug+rwx storage bootstrap/cache

# reload apache
sudo systemctl reload apache2

# done
echo 'webserver is up vist http://127.0.0.1 to view website'

