apt update
sudo apt install -y nginx 
apt install -y mysql-server 
apt install -y php8.3-fpm php-mysql
sudo mkdir /var/www/wordpress
sudo chown -R $USER:$USER /var/www/wordpress
cat <<\EOF> /etc/nginx/sites-available/wordpress
server {
    listen 80;
    server_name localhost;
    root /var/www/wordpress;

    index index.html index.htm index.php;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.3-fpm.sock;
     }

    location ~ /\.ht {
        deny all;
    }

}

EOF

sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
sudo unlink /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx
cat <<\EOF> /var/www/wordpress/index.html
<html>
  <head>
    <title>your_domain website</title>
  </head>
  <body>
    <h1>Hello World!</h1>

    <p>This is the landing page of <strong>your_domain</strong>.</p>
  </body>
</html>
EOF

cat <<\EOF> /var/www/wordpress/info.php
<?php
phpinfo();
EOF

