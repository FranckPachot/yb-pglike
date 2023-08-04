DB=${POSTGRES_DB:-$POSTGRES_USER}"
/home/yugabyte/postgres/bin/pg_isready -h $(hostname) -p 5432 -d ${DB:-yugabyte} && sleep 3
