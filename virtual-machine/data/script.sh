#!/bin/bash

# Usage: ./script.sh dbname hostname password

if [ "$#" -ne 3 ]; then
        echo "usage: $0 <dbname> <hostname> <password>"
        exit 1
fi

DB_NAME=$1
HOST=$2
PASSWORD=$3
BACKUP_DIR="/tmp/backups"
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_backup_${TIMESTAMP}.sql"

# Set password as environment variable (only for this command)
export PGPASSWORD="$PASSWORD"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Run pg_dump
pg_dump -U postgres -h "$HOST" -p 5432 "$DB_NAME" > "$BACKUP_FILE"

# Unset the password immediately
unset PGPASSWORD

# Verify backup was created
if [ -f "$BACKUP_FILE" ]; then
        echo "Backup successful: $BACKUP_FILE"
        exit 0
else
        echo "Backup failed!"
        exit 1
fi