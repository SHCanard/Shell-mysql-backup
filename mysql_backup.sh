#!/bin/bash

DATE=`date +%y_%m_%d`

#First save in root directory, 5 days of retention

OLDDATE=$(date -d '5 days ago' +%y_%m_%d)

LISTEBDD=$( echo 'show databases' | mysql -uroot -p*password* )

rm -f /root/backup/sql/*_mysql_$OLDDATE.sql.gz

for SQL in $LISTEBDD
do
if [ $SQL = "db1" ] || [ $SQL = "db2" ]; then
mysqldump -uroot -p*password* $SQL | gzip > /root/backup/sql/$SQL"_mysql_"$DATE.sql.gz
fi
done

#Second save in mnt directory, 10 days of retention

OLDDATE=$(date -d '10 days ago' +%y_%m_%d)

LISTEBDD=$( echo 'show databases' | mysql -uroot -p*password* )

rm -f /mnt/backup/sql/*_mysql_$OLDDATE.sql.gz

for SQL in $LISTEBDD
do
if [ $SQL = "db1" ] || [ $SQL = "db2" ]; then
mysqldump -uroot -p*password* $SQL | gzip > /mnt/backup/sql/$SQL"_mysql_"$DATE.sql.gz
fi
done
