#!/bin/bash

apt update
apt -y install apache2

h_name=`curl http://169.254.169.254/latest/meta-data/hostname`
echo "<h2>Hello ${my_name} from $h_name</h2>" > /var/www/html/index.html
service apache2 start
service apache2 enable