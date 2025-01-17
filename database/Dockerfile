FROM postgres:14-alpine

ENV POSTGRES_PASSWORD=aalonso
ENV POSTGRES_USER=aalonso
ENV POSTGRES_DB=database_nyc

COPY data_tables.sh /usr/local/bin
#COPY 1-schema.sql /docker-entrypoint-initdb.d/1-schema.sql
#COPY 2-ddl.sql /docker-entrypoint-initdb.d/2-ddl.sql