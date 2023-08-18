- Redmine ./tests/redmine
A flexible project management web application written using Ruby on Rails framework.
[^1] [[PR]](https://github.com/requarks/wiki/pull/6633)

_Fails on serialzable even without colocation and with read committed_

```
2023-08-18 15:02:55.790 UTC [538] LOG:  duration: 0.556 ms  plan:
        Query Text: UPDATE "users" SET mail_notification = 'only_my_events' WHERE (mail_notification NOT IN ('all', 'selected'))
        Update on users  (cost=0.00..102.50 rows=1000 width=1312) (actual time=0.552..0.552 rows=0 loops=1)
          ->  Seq Scan on users  (cost=0.00..102.50 rows=1000 width=1312) (actual time=0.550..0.550 rows=0 loops=1)
                Filter: ((mail_notification)::text <> ALL ('{all,selected}'::text[]))
                Rows Removed by Filter: 1
2023-08-18 15:02:55.791 UTC [538] LOG:  statement: ALTER TABLE "users" DROP COLUMN "mail_notification_bool"
2023-08-18 15:02:55.949 UTC [538] LOG:  execute <unnamed>: INSERT INTO "schema_migrations" ("version") VALUES ($1) RETURNING "version"
2023-08-18 15:02:55.949 UTC [538] DETAIL:  parameters: $1 = '20100129193402'
2023-08-18 15:02:55.950 UTC [538] LOG:  duration: 1.019 ms  plan:
        Query Text: INSERT INTO "schema_migrations" ("version") VALUES ($1) RETURNING "version"
        Insert on schema_migrations  (cost=0.00..0.01 rows=1 width=32) (actual time=0.051..0.051 rows=1 loops=1)
          ->  Result  (cost=0.00..0.01 rows=1 width=32) (actual time=0.001..0.001 rows=1 loops=1)
2023-08-18 15:02:55.950 UTC [538] LOG:  statement: COMMIT
2023-08-18 15:02:55.953 UTC [538] ERROR:  Transaction c2ad4eed-a55a-42fb-b525-a0ac2be2ae7a expired or aborted by a conflict: 40001
2023-08-18 15:02:55.953 UTC [538] STATEMENT:  COMMIT
2023-08-18 15:02:55.955 UTC [538] LOG:  statement: ROLLBACK
2023-08-18 15:02:55.955 UTC [538] WARNING:  there is no transaction in progress
2023-08-18 15:02:55.955 UTC [538] LOG:  statement: SELECT pg_advisory_unlock(5339476299225889275)
2023-08-18 15:02:55.958 UTC [538] LOG:  duration: 0.009 ms  plan:
        Query Text: SELECT pg_advisory_unlock(5339476299225889275)
        Result  (cost=0.00..0.01 rows=1 width=1) (actual time=0.002..0.003 rows=1 loops=1)
```



