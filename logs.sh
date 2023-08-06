DIR=${PGDATA:-/var/lib/postgresql/data}
cd $DIR/logs/tserver
tail -F $(ls -r postgres* | head -1)
