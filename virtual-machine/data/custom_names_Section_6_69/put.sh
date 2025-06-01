#!/bin/zsh

# Usage: ./put.sh <fileName> <DB_NAME> <HOST_NAME> <TABLE_NAME> <password>
# Example: ./put.sh people.txt people db_host register admin
if [ "$#" -ne 5  ]; then
  echo "usage: $0 <targetFile> <dbname> <hostName> <tableName> <password>"
  exit 1
fi

DB_NAME=$2
HOST=$3
TABLE_NAME=$4
PASSWORD=$5
totalRowsInFile=$(awk 'END {print NR}' $1)
counter=1
name='';
lastname='';

# Set password as environment variable (only for this command)
export PGPASSWORD="$PASSWORD"

while [ $counter -le $totalRowsInFile ]; do
  name=$(sed -n "${counter}p" $1 | awk -F ',' '{print $1}')
  lastName=$(sed -n "${counter}p" $1 | awk -F ',' '{print $2}')
  age=$(shuf -i 20-25 -n 1)

  psql -h "$HOST" -U postgres -d "$DB_NAME" -c "insert into $TABLE_NAME (id, name, lastname, age) values ($counter, '$name', '$lastName', $age)"

  echo "$counter, $name $lastName, $age was correctly imported";
  counter=$(($counter+1))

done

# Unset the password immediately
unset PGPASSWORD