#!/bin/bash

execute_migration() {
    migration_file=$1
    if [ -f "$migration_file" ]; then
        echo "Executing migration: $migration_file"
        export PGPASSWORD="${POSTGRES_PASSWORD}"
        psql -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" -p "${PORT}" -h "${POSTGRES_HOST}" -f "$migration_file" -a
        unset PGPASSWORD
    else
        echo "Migration file not found: $migration_file"
    fi
}

connect() {
    local retries=10
    local delay=5
    local attempts=0
    local success=false
    until $success || [ $attempts -ge $retries ]; do
        attempts=$((attempts + 1))
        echo "Attempt $attempts to connect to the database..."
        export PGPASSWORD="${POSTGRES_PASSWORD}"
        tables_count=$(psql -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" -p "${PORT}" -h "${POSTGRES_HOST}" -tAc "SELECT count(*) FROM information_schema.tables WHERE table_schema = 'public';")
        if [ $? -eq 0 ]; then
            if [ $tables_count -gt 0 ]; then
                echo "Database filled. Migration not needed."
                exit 0
            fi
            echo "Database connection success"
            success=true
        else
            echo "Database migration failed, retrying in $delay seconds..."
            sleep "$delay"
        fi
        unset PGPASSWORD
    done
    if ! $success; then
        echo "Failed to migrate to the database after $retries attempts"
        exit 1
    fi
}

MIGRATION_VERSION=${MIGRATION_VERSION:-latest}

connect

for migration_file in $(ls /app/migrations/migrate_*.sql | sort -V); do
    version=$(basename "$migration_file" | sed 's/^migrate_//' | sed 's/\.sql$//')
    execute_migration "$migration_file"
    if [[ "$version" == "${MIGRATION_VERSION}" ]]; then
        break
    fi
done