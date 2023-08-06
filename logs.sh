DIR=${PGDATA:-/var/lib/postgresql/data}
cd $DIR/logs/tserver
tail -n 10000 -F $(ls -r postgres* | head -1)
