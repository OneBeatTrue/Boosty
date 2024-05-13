#!/bin/bash

backup_database() {
    local backup_dir="$(dirname "$(realpath "$0")")/${BACKUP_DIR}"
    local timestamp=$(date +'%Y-%m-%d_%H-%M-%S')
    local backup_filename="${timestamp}_${POSTGRES_DB}.sql"
    export PGPASSWORD="${POSTGRES_PASSWORD}"
    local backup_command="pg_dump -U ${POSTGRES_USER} -d ${POSTGRES_DB} -p ${PORT} -h ${POSTGRES_HOST} -f $backup_dir/$backup_filename"
    echo "Backing up database..."
    $backup_command
    echo "Backing up finished"
    unset PGPASSWORD
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
