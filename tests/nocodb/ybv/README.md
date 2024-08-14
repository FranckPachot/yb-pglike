Example of migration with YugabyteDB Voyager
```

# start the application on the PostgreSQL database

docker compose up -d

# test

... (test the application)

# run the migration to YugabyteDB

docker compose up -d --scale=migrate=1
until docker compose logs migrate | tee /dev/stderr | grep 'ybv-migrate-1  | Import data complete' ; do sleep 1 ; done

# restart the app with on YugabyteDB database

docker compose --env-file .new.env up -d

# reset pg_stat_statements, create some documents, and check SQL execution time

docker compose exec -it pg bash -c 'PGPASSWORD=pgpassword PGUSER=pguser psql -h yb -p 5433 pgdb -c "select pg_stat_statements_reset()"'

... (test the application)

docker compose exec -it pg bash -c 'PGPASSWORD=pgpassword PGUSER=pguser psql -h yb -p 5433 pgdb -c "\pset pager off" -c "select mean_time, calls, substr(query,1,80) from pg_stat_statements order by 1 asc"'

```
