# yb-pglike
This builds an image with [YugabyteDB](https://www.yugabyte.com/yugabytedb/) (re-architected PostgreSQL to be cloud native, resilient and horizontally scalable) configured to be a drop-in replacement of the [PostgreSQL docker image](https://hub.docker.com/_/postgres/) (same behavior, same environment variables...)

## usage

To run with it, replace the postgres image with this one.

For example, in docker compose, replace 
```
    image: postgres
``` 
with:
```
    build: https://github.com/FranckPachot/yb-pglike.git
``` 

## List of applications validated with this docker image or similar config

Here are some applications tken from that I have tested, replacing the PostgreSQL image by this YugabyteDB image. You can do the same, please let me know to add to the list.

### With PR submitted

- https://github.com/awslabs/aws-dataall
A modern data marketplace that makes collaboration among diverse users (like business, analysts and engineers) easier, increasing efficiency and agility in data projects on AWS.
[^2] [[PR]](https://github.com/awslabs/aws-dataall/pull/608)

- https://github.com/requarks/wiki
Wiki.js | A modern and powerful wiki app built on Node.js
[^1] [[PR]](https://github.com/requarks/wiki/pull/6633)


[^1]: TODO: set colocated to true when [#17929](https://github.com/yugabyte/yugabyte-db/issues/17929) is fixed
[^2]: Application requires no gap sequences (`ysql_sequence_cache_minval=1`)


