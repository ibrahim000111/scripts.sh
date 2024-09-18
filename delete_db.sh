DBUSER='root'
DBPASS='123'

#echo "fetching all databases"

#mysql -u $DBUSER -p$DBPASS -e "SHOW DATABASES" > deletable-dbs.sql;

SQLFILE='./deletable-dbs.sql'

echo '* Dropping ALL databases'

DBS="$(mysql -u$DBUSER -p$DBPASS -Bse 'show databases' | grep -v Database | grep -v database | grep -v mysql | grep -v information_schema)"

for db in $DBS; do
    echo "Deleting $db"
    mysql -u$DBUSER -p$DBPASS -Bse "drop database $db; select sleep(0.1);"
done
