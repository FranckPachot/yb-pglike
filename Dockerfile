FROM docker.io/yugabytedb/yugabyte:latest
COPY entrypoint.sh /usr/local/bin/
COPY healthcheck.sh /usr/local/bin/
COPY logs.sh /usr/local/bin/
COPY config.flags /tmp/
RUN chmod 777 /usr/local/bin/entrypoint.sh
RUN chmod 777 /usr/local/bin/healthcheck.sh
RUN chmod 777 /usr/local/bin/logs.sh
VOLUME /var/lib/postgresql/data
HEALTHCHECK --start-period=15s CMD /usr/local/bin/healthcheck.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
