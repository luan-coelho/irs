#!/bin/bash

# Inicializar o diretório de dados do MariaDB
mysql_install_db

# Iniciar o serviço do MariaDB em background
mysqld_safe &

# Esperar que o servidor do MariaDB comece (simples espera de inicialização)
sleep 10

# Comandos para configurar o banco de dados
mysql -u root -e "CREATE DATABASE unitins;"
mysql -u root -e "CREATE USER 'root'@'%' IDENTIFIED BY 'unitins';"
mysql -u root -e "GRANT ALL PRIVILEGES ON unitins.* TO 'root'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"
mysql -u root -e "EXIT;"

# Iniciar PHP-FPM
php-fpm -D

# Executar o Nginx em foreground
nginx -g 'daemon off;'
