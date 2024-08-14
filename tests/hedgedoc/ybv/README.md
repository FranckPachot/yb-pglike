Example if migration with YugabyteDB Voyager
```

# start the application on the PostgreSQL database

docker compose up -d

# create some documents using the API

time for f in $( find /usr -name README )
do
curl -X POST "http://localhost:8080/new" -H "Content-Type: text/markdown" -d "@$f"
done

# run the migration to YugabyteDB

docker compose up -d --scale=migrate=1
until docker compose logs migrate | tee /dev/stderr | grep 'ybv-migrate-1  | Import data complete' ; do sleep 1 ; done

# restart the app with on YugabyteDB database

docker compose --env-file .new.env up -d

# reset pg_stat_statements, create some documents, and check execution time

docker compose exec -it pg bash -c 'PGPASSWORD=pgpassword PGUSER=pguser psql -h yb -p 5433 pgdb -c "select pg_stat_statements_reset()"'

time for f in $( find /usr -name README )
do
curl -X POST "http://localhost:8080/new" -H "Content-Type: text/markdown" -d "@$f"
done

docker compose exec -it pg bash -c 'PGPASSWORD=pgpassword PGUSER=pguser psql -h yb -p 5433 pgdb -c "\pset pager off" -c "select mean_time, calls, query from pg_stat_statements order by 1 desc"'

```
