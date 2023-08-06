for c in $(docker ps -q)
do
docker exec -i $c bash -c 'type ysqlsh >/dev/null && psql -p 5432' <<'SQL'
\pset format html
select * from yb_servers();
select 
 to_char(total_time/calls/1000,'99999.99') as "secs/call",
 case when rows>0 then to_char(rows/calls/1000,'99999.9') end as "rows/call",
 *
 from (select oid dbid, datname from pg_database ) as db
 join pg_stat_statements using(dbid) order by total_time desc;
SQL
echo " $* " | grep reset && 
docker exec -i $c bash -c 'type ysqlsh >/dev/null && psql -p 5432' <<'SQL'
select pg_stat_statements_reset();
SQL
done | tee .tmp.html
