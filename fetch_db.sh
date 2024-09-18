DBUSER='root'
DBPASS='123'

echo "fetching all databases"

mysql -u$DBUSER -p$DBPASS -e "SHOW DATABASES" > deletable2-dbs.sql;

