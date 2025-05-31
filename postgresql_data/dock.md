#### postgresql:
**Log in to PostgreSQL**
`psql -U postgres`

**Inside psql:**
\l - List database
\c postgres - Switch to 'postgres' database
\dt - List tables
\q - Exit
\d table - Table info
\d+ table - Extended table info 
SELECT version(); - Check PostgreSQL version

**Connect to PostgreSQL from inside the `remote-host` container:**
`psql -h db_host -U postgres -W`

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
```CREATE TABLE info (
    name VARCHAR(20),
    lastname    VARCHAR(20),
    age     SMALLINT
);
```

**Insert into table**
```
INSERT INTO info VALUES(
    'reza',
    'fitriaman',
    '38'
);
```

**Insert into table from another container**
```
psql -h db_host -U postgres -d people -c "INSERT INTO register(id, username, lastname, age) VALUES (999, 'master', 'fitriaman', 38);"
```

**SQL-standard Command for showing table info**
-- Show columns (information_schema)
```
SELECT column_name, data_type
FROM information_schema.column
WHERE table_name = 'register';
```

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

**Count file in bash**
[Example](https://www.baeldung.com/linux/bash-count-lines-in-file)
