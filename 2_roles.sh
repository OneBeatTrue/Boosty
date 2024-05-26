#!/bin/bash

export PGPASSWORD="${POSTGRES_PASSWORD}"

psql -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" -p "${PORT}" -h "${POSTGRES_HOST}" -c "CREATE ROLE reader;"
psql -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" -p "${PORT}" -h "${POSTGRES_HOST}" -c "GRANT SELECT ON ALL TABLES IN SCHEMA public TO reader;"

psql -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" -p "${PORT}" -h "${POSTGRES_HOST}" -c "CREATE ROLE writer;"
psql -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" -p "${PORT}" -h "${POSTGRES_HOST}" -c "GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO writer;"

psql -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" -p "${PORT}" -h "${POSTGRES_HOST}" -c "CREATE USER analytic WITH PASSWORD 'analytic_password';"
psql -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" -p "${PORT}" -h "${POSTGRES_HOST}" -c "GRANT SELECT ON users TO analytic;"

psql -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" -p "${PORT}" -h "${POSTGRES_HOST}" -c "CREATE ROLE no_login NOLOGIN;"
psql -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" -p "${PORT}" -h "${POSTGRES_HOST}" -c "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO no_login;"

for user in $(cat /app/users.txt); do
    echo "Full access role to : $user"
    psql -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" -p "${PORT}" -h "${POSTGRES_HOST}" -c "CREATE USER $user;"
    psql -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" -p "${PORT}" -h "${POSTGRES_HOST}" -c "GRANT no_login TO $user"
done

unset PGPASSWORD