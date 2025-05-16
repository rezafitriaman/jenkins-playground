#### postgresql:
**Log in to PostgreSQL**
`psql -U postgres`

**Inside psql:**
\l - List database
\c postgres - Switch to 'postgres' database
\dt - List tables
\q - Exit
SELECT version(); - Check PostgreSQL version

**Connect to PostgreSQL from inside the `remote-host` container:**
`psql -h db_postgresql_jenkins -U postgres -W`

-h db_postgresql_jenkins: Connects to the PostgreSQL container by its hostname (Docker resolves this automatically if both containers are on the same network).
-U postgres: Uses the PostgreSQL superuser.
-W: Forces a password prompt (enter admin as per your docker-compose.yml).

**Install `psql`:**
`yum -y update && yum -y install postresql`

**Verify PostgreSQL is running**
`docker exec db_postgresql_jenkins pg_isready`

**verify that the containers are on the same network:**
```
docker inspect db_postresql_jenkins | grep NetworkMode
docker inspect remote-host_jenkins | grep NetworkMode
```
Tip: or use `| fzf`

**Create table**
CREATE TABLE info (
    name VARCHAR(20),
    lastname    VARCHAR(20),
    age     SMALLINT
);

**Insert into table**
INSERT INTO info VALUES(
    'reza',
    'fitriaman',
    '38'
);

**Show rows/data**
SELECT * FROM info;

**Describe the Table Structure**
\d info
\d tableName

**Dump postgresql to a file**
`pg_dump -U postgres -h localhost -p 5432 mydatabase > db_backup_$(date +%Y-%m-%d).sql`
Or:
`pg_dump -U postgres -h db_postgresql_jenkins -p 5432 testdb > db_backup_$(date +%Y-%m-%d).sql`

To restore dump file:
`psql -U postgres -d mydb -f backup.sql`

For more info:
(more info)[https://www.geeksforgeeks.org/how-to-dump-and-restore-postgresql-database/]
