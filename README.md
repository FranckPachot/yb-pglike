# yb-pglike
This builds an image with [YugabyteDB](https://www.yugabyte.com/yugabytedb/) (re-architected PostgreSQL to be cloud native, resilient and horizontally scalable) configured to be a drop-in replacement of the [PostgreSQL docker image](https://hub.docker.com/_/postgres/) (same behavior, same environment variables...)

To run with it, replace the postgres image with this one.

For example, in docker compose, replace `image: postgres` with:
```
    build: https://github.com/FranckPachot/yb-pglike.git
``` 


