

# If /root/.my.cnf exists then it won't ask for root password
if [ -f /root/.my.cnf ]; then
	echo "Enter database name!"
	read dbname
    
	echo "Creating new MySQL database..."
	mysql -e "CREATE DATABASE ${dbname} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
	echo "Database successfully created!"
	
	echo "Enter database user!"
	read username
    
	echo "Enter the PASSWORD for database user!"
	echo "Note: password will be hidden when typing"
	read -s userpass
    
	echo "Creating new user..."
	mysql -e "CREATE USER ${username}@localhost IDENTIFIED BY '${userpass}';"
	echo "User successfully created!"

	echo "Granting ALL privileges on ${dbname} to ${username}!"
	mysql -e "GRANT ALL PRIVILEGES ON ${dbname}.* TO '${username}'@'localhost';"
	mysql -e "FLUSH PRIVILEGES;"
	echo "You're good now :)"
	exit
	
# If /root/.my.cnf doesn't exist then it'll ask for root password	
else
	echo "Please enter root user MySQL password!"
	echo "Note: password will be hidden when typing"
	read -s rootpasswd
    
	echo "Enter database name!"
	read dbname
    
	echo "Creating new MySQL database..."
	mysql -uroot -p${rootpasswd} -e "CREATE DATABASE ${dbname} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
	echo "Database successfully created!"
    
	echo "Enter database user!"
	read username
    
	echo "Enter the PASSWORD for database user!"
	echo "Note: password will be hidden when typing"
	read -s userpass
    
	echo "Creating new user..."
	mysql -uroot -p${rootpasswd} -e "CREATE USER ${username}@localhost IDENTIFIED BY '${userpass}';"
	echo "User successfully created!"
	
	echo "Granting ALL privileges on ${dbname} to ${username}!"
	mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON ${dbname}.* TO '${username}'@'localhost';"
	mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"
	echo "You're good now :)"

	read -p "what the name of root folder:" root_folder
	mkdir -p /var/www/${root_folder}
	sudo cp -a /tmp/wordpress/. /var/www/${root_folder}
        sed -i "s/database_name_here/${dbname}/g" /var/www/${root_folder}/wp-config.php
        sed -i "s/username_here/${username}/g" /var/www/${root_folder}/wp-config.php
        sed -i "s/password_here/${userpass}/g" /var/www/${root_folder}/wp-config.php

        #rm -r /home/wp-config.php
        #cp /tmp/wordpress/wp-config.php /home
        #sed -i "s/database_name_here/${dbname}/g" /home/wp-config.php 
        #sed -i "s/username_here/${username}/g" /home/wp-config.php
        #sed -i "s/password_here/${userpass}/g" /home/wp-config.php
	echo "/var/www/${root_folder}/wp-config.php edited done"
	exit
fi


#curl -LO https://wordpress.org/latest.tar.gz
#tar xzvf latest.tar.gz
#cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
#sudo cp -a /tmp/wordpress/. /var/www/wordpress
#sudo chown -R www-data:www-data /var/www/wordpress

