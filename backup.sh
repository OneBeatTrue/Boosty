#!/bin/bash

backup_database() {
    local backup_dir="$(dirname "$(realpath "$0")")/${BACKUP_DIR}"
    local timestamp=$(date +'%Y-%m-%d_%H-%M-%S')
    local backup_filename="${timestamp}_${POSTGRES_DB}.sql"

    local retries=10
    local delay=5
    local attempts=0
    local success=false
    until $success || [ $attempts -ge $retries ]; do
        attempts=$((attempts + 1))
        echo "Attempt $attempts to connect to the database..."
        export PGPASSWORD="${POSTGRES_PASSWORD}"
        pg_dump -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" -p "${PORT}" -h "${POSTGRES_HOST}" -f "$backup_dir/$backup_filename"
        if [ $? -eq 0 ]; then
            echo "Database backup successful"
            success=true
        else
            echo "Database backup failed, retrying in $delay seconds..."
            sleep "$delay"
        fi
        unset PGPASSWORD
    done
    if ! $success; then
        echo "Failed to connect to the database after $retries attempts"
        exit 1
    fi
}

remove_old_backups() {
    local backup_dir="$(dirname "$(realpath "$0")")/${BACKUP_DIR}"
    cd "$backup_dir" || exit
    local backups=$(ls | sort)
    local num_backups=$(echo "$backups" | wc -l)
    while [ "$num_backups" -gt "${M}" ]; do
        local oldest_backup=$(echo "$backups" | head -n 1)
        rm "$oldest_backup"
        backups=$(echo "$backups" | tail -n +2)
        num_backups=$((num_backups - 1))
    done
}

path="$(dirname "$(realpath "$0")")/${BACKUP_DIR}"
if [ ! -d "$path" ]; then
    echo "$path not exists"
    exit 1
fi

while true; do
    backup_database
    remove_old_backups
    sleep "${N}"h
done

}