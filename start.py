import psycopg2
import os
import re
import time

time.sleep(10)
def get_migration_files_until_version(migration_version):
    current_dir = os.path.dirname(os.path.abspath(__file__))
    migration_files = [f for f in os.listdir(os.path.join(current_dir, "migrations")) if f.endswith(".sql")]
    sorted_migrations = [os.path.join(os.path.dirname(os.path.abspath(__file__)), "migrations", "clear.sql")]

    if not os.path.exists(os.path.join(current_dir, "migrations", f"migrate_{migration_version}.sql")):
        migration_version = max([re.search(r'migrate_(\d+\.\d+\.\d+)\.sql', f).group(1) for f in migration_files])

    for migration_file in sorted(migration_files):
        match = re.search(r'migrate_(\d+\.\d+\.\d+)\.sql', migration_file)
        if match:
            version = match.group(1)
            if version <= migration_version:
                sorted_migrations.append(os.path.join(current_dir, "migrations", migration_file))

    return sorted_migrations


def execute(conn, migration_file):
    cursor = conn.cursor()
    if os.path.exists(migration_file):
        with open(migration_file, 'r') as file:
            migration_sql = file.read()

        try:
            cursor.execute(migration_sql)
            conn.commit()
            print("Migration successful.")
        except Exception as e:
            print(f"Migration failed: {e}")
            conn.rollback()
    else:
        print("Migrations file not found.")
    cursor.close()

def main():
    conn = psycopg2.connect(
        dbname=os.environ.get("POSTGRES_DB"),
        user=os.environ.get("POSTGRES_USER"),
        password=os.environ.get("POSTGRES_PASSWORD"),
        host=os.environ.get("POSTGRES_HOST"),
        port=os.environ.get("EXTERNAL_PORT")
    )

    migration_version = os.environ.get("MIGRATION_VERSION", "latest")

    for migration in get_migration_files_until_version(migration_version):
        execute(conn, migration)

    conn.close()


if __name__ == "__main__":
    main()
