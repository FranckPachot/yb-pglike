# yb-pglike
This builds an image with [YugabyteDB](https://www.yugabyte.com/yugabytedb/) (re-architected PostgreSQL to be cloud native, resilient and horizontally scalable) configured to be a drop-in replacement of the [PostgreSQL docker image](https://hub.docker.com/_/postgres/) (same behavior, same environment variables...)

## Usage

To run with it, replace the postgres image with this one.

For example, in docker compose, replace 
```
    image: postgres
``` 
with:
```
    build: https://github.com/FranckPachot/yb-pglike.git
```

## Reason

With this single-node image, the goal is to have the same behavior as PostgreSQL. There are some advantages: YugabyteDB doesn't need VACUUM and solves many related problems (see [Which PostgreSQL problems are solved with YugabyteDB](https://dev.to/yugabyte/which-postgresql-problems-are-solved-with-yugabytedb-2gm)). For production, simply add two additional replicas (same command with additional `--join=` with the fully qualified address of the first node) and it become resilient to any node failure. You can also use a managed sevice on 

## List of applications validated with this docker image or similar config

Here are some applications I have tested, replacing the PostgreSQL image by this YugabyteDB image. You can do the same, please let me know to add to the list.

### Tested and working

- **Jira** ([docker compose](https://github.com/FranckPachot/yb-pglike/tree/main/tests/jira))
An agile project management tool used by teams to plan, track, release and support software
- **Confluence ([docker compose](https://github.com/FranckPachot/yb-pglike/tree/main/tests/confluence))
A collaborative platform used for creating, sharing, and organizing content within teams and organizations
- **Plume** ([docker compose](https://github.com/FranckPachot/yb-pglike/tree/main/tests/plume))
A a federated blogging engine, based on ActivityPub. 
- **Commento** ([docker compose](https://github.com/FranckPachot/yb-pglike/tree/main/tests/commento))
A fast, bloat-free comments platform
- **Firefly III** ([docker compose](https://github.com/FranckPachot/yb-pglike/tree/main/tests/firefly))
A personal finances manager
- **HedgeDoc** ([docker compose](https://github.com/FranckPachot/yb-pglike/tree/main/tests/hedgedoc))
Was CodiMD: create real-time collaborative markdown notes
- **NocoBase** ([docker compose](https://github.com/FranckPachot/yb-pglike/tree/main/tests/nocobase))
A scalability-first, open-source no-code/low-code platform to build internal tools.
- **Wiki.js** ([docker compose](https://github.com/FranckPachot/yb-pglike/tree/main/tests/wikijs)) [^17929]
A modern and powerful wiki app built on Node.js
- **NocoDB** ([docker compose](https://github.com/FranckPachot/yb-pglike/tree/main/tests/nocodb)) [^17929] (Slow [^7745])
An Open Source Alternative to Airtable
- **Kine** [^6041] Alternative to Etcd

### Tested, working, and PR submitted

- https://github.com/awslabs/aws-dataall
A modern data marketplace that makes collaboration among diverse users (like business, analysts and engineers) easier, increasing efficiency and agility in data projects on AWS.
[[PR]](https://github.com/awslabs/aws-dataall/pull/608)

- https://github.com/requarks/wiki
Wiki.js | A modern and powerful wiki app built on Node.js
[^17929] [[PR]](https://github.com/requarks/wiki/pull/6633)

### Tests waiting for open issues in YugabyteDB

- Redmine https://github.com/FranckPachot/yb-pglike/tree/main/tests/redmine [^17929]
A flexible project management web application written using Ruby on Rails framework.

- Mattermost https://github.com/FranckPachot/yb-pglike/blob/main/tests/mattermost/docker-compose.yml [^14566] 
Open source platform that provides secure collaboration for technical and operational teams that work in environments with complex nation-state level security and trust requirements.




[^17929]: set colocated to true when [#17929](https://github.com/yugabyte/yugabyte-db/issues/17929) is fixed.
[^6041]: Application requires no gap sequences (`ysql_sequence_cache_minval=1`).
[^14566]: DROP CONSTRAINT IF EXISTS fails [#14566](https://github.com/yugabyte/yugabyte-db/issues/14566).
[^7745]: queries on catalog are slow [#7745](https://github.com/yugabyte/yugabyte-db/issues/7745).


