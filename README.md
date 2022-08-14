# mysql

sudo docker run --rm \       
--name=mysql-pzn-db \
-e MYSQL_DATABASE=mysqlpzn-db \
-e MYSQL_USER=yukbelajar \
-e MYSQL_PASSWORD=PNSJkxXvVNDAhePMuExTBuRR \
-e MYSQL_ROOT_PASSWORD=PNSJkxXvVNDAhePMuExTBuRR \
-e TZ=Asia/Jakarta \
-p 6603:3306 \
-v "$PWD/docker/mysql-pzn-db/conf.d":/etc/mysql/conf.d \
-v "$PWD/storage/docker/mysqlpzn-db-data":/var/lib/mysql \
mysql

