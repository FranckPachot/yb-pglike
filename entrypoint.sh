#!/usr/bin/bash

# This Dockefile is compatible with the PostgreSQL docker image environment variables

# Start YugabyteDB for the first time, to create the database and user
# on port 5433 because some applications test the availability of the db by `nc -z 5432'
# and may think it is available too early

mkdir -p /docker-entrypoint-initdb.d
cat    > /docker-entrypoint-initdb.d/00000000.sql <<SQL
create database "${POSTGRES_DB:-$POSTGRES_USER}" with colocation = ${YB_COLOCATION:-true};
create user "${POSTGRES_USER}";
alter user "${POSTGRES_USER}" password '${POSTGRES_PASSWORD}'
grant create on database "${POSTGRES_DB:-$POSTGRES_USER}" to "${POSTGRES_USER}";
SQL

# because if issue #17929 we may need to disable colocation
sed -e "/--ysql_colocate_database_by_default=/s/true/${YB_COLOCATION:-true}/" /tmp/config.flags

yugabyted start $* \
 --ysql_port=5433 \
 --tserver_flags=flagfile=/tmp/config.flags \
 --master_flags=flagfile=/tmp/config.flags \
 --initial_scripts_dir=/docker-entrypoint-initdb.d \
 --base_dir=${PGDATA:-/var/lib/postgresql/data} 

# stop to restart on port 5432
yugabyted stop \
 --base_dir=${PGDATA:-/var/lib/postgresql/data} 

cat > ~/.pgpass <<CAT
$(hostname):5432:${POSTGRES_USER}:${POSTGRES_DB:-$POSTGRES_USER}:${POSTGRES_USER}:${POSTGRES_PASSWORD}
CAT
chmod 600 ~/.pgpass

cat >> /usr/local/bin/psql <<CAT
PGHOST=$(hostname) PGPORT=5432 ysqlsh \$@
CAT
chmod 744 /usr/local/bin/psql

echo "

 Restarting on port 5432...

"
yugabyted start $* \
 --ysql_port=5432 \
 --background=true \
 --base_dir=${PGDATA:-/var/lib/postgresql/data} 

/usr/local/bin/logs.sh



