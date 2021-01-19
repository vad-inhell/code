#!/bin/bash
SMBUSER="backup-user"
SMBPWD="PASSSSSSSWORDD"
DBUSER="db-user"
DBPWD="PASSSSSSSWORDD"
mount -t cifs -o username=$SMBUSER,password=$SMBPWD,vers=1.0 //192.168.62.210/Volume_1/db_backup/ /mnt/db/
mkdir /mnt/db/$HOSTNAME
#find /mnt/db/$HOSTNAME/ *.* -mtime  +14 -delete;
#$OUTPUT=/mnt/db/$HOSTNAME
databases=`mysql --user=$DBUSER --password=$DBPWD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`
for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
        mysqldump --force --opt --user=$DBUSER --password=$DBPWD --databases $db > /mnt/db/$HOSTNAME/`date +%Y%m%d`.$db.sql
        gzip /mnt/db/$HOSTNAME/`date +%Y%m%d`.$db.sql
       gpg --no-use-agent --yes --batch --passphrase=PASSSSSSSWORDD -c /mnt/db/$HOSTNAME/`date +%Y%m%d`.$db.sql.gz
        mysql -uroot -pPASSSSSSSWORDD -DSyslog -e"TRUNCATE TABLE SystemEvents"
        find /mnt/db/$HOSTNAME/`date +%Y%m%d`.$db.sql.gz -delete
    fi
done
