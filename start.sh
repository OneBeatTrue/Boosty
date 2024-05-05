#!/bin/bash

execute_migration() {
    migration_file=$1
    if [ -f "$migration_file" ]; then
        echo "Executing migration: $migration_file"
        psql -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" -f "$migration_file" -a
#        PGPASSWORD="${POSTGRES_PASSWORD}" psql -U "${POSTGRES_USER}" -h "${POSTGRES_HOST}" -d "${POSTGRES_DB}" -p "${INTERNAL_PORT}" -f "$migration_file" -a
    else
        echo "Migration file not found: $migration_file"
    fi
}

MIGRATION_VERSION=${MIGRATION_VERSION:-latest}

clear_sql="/app/migrations/clear.sql"
execute_migration "$clear_sql"

for migration_file in $(ls /app/migrations/migrate_*.sql | sort -V); do
    version=$(basename "$migration_file" | sed 's/^migrate_//' | sed 's/\.sql$//')
    execute_migration "$migration_file"
    if [[ "$version" == "${MIGRATION_VERSION}" ]]; then
        break
    fi
done

psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c "CREATE ROLE reader;"
psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c "GRANT SELECT ON ALL TABLES IN SCHEMA public TO reader;"

psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c "CREATE ROLE writer;"
psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c "GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO writer;"

psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c "CREATE USER analytic WITH PASSWORD 'analytic_password';"
psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c "GRANT SELECT ON users TO analytic;"

psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c "CREATE ROLE no_login NOLOGIN;"
psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO no_login;"

for user in $(cat /app/users.txt); do
    echo "Full access role to : $user"
    psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c "CREATE USER $user;"
    psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -c "GRANT no_login TO $user"
done