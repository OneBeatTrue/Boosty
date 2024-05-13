import os
import time


def backup_database():
    dbname = os.environ.get("POSTGRES_DB")
    dbuser = os.environ.get("POSTGRES_USER")
    dbpassword = os.environ.get("POSTGRES_PASSWORD")
    port = os.environ.get("PORT")
    host = os.environ.get("POSTGRES_HOST")
    backup_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), os.environ.get("BACKUP_DIR"))
    timestamp = time.strftime('%Y-%m-%d_%H-%M-%S')
    backup_filename = f"{timestamp}_{dbname}.sql"
    backup_command = f"PGPASSWORD={dbpassword} pg_dump -U {dbuser} -d {dbname} -p {port} -h {host} > {backup_dir}/{backup_filename}"
    print("Backing up database...")
    os.system(backup_command)
    print("Backing up finished")


def remove_old_backups():
    backup_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), os.environ.get("BACKUP_DIR"))
    max_backups = int(os.environ.get("M"))
    backups = sorted(os.listdir(backup_dir))
    while len(backups) > max_backups:
        oldest_backup = backups.pop(0)
        os.remove(os.path.join(backup_dir, oldest_backup))


if __name__ == "__main__":
    path = os.path.join(os.path.dirname(os.path.abspath(__file__)), os.environ.get("BACKUP_DIR"))
    if not os.path.exists(path):
        print(f"{path} not exists")
        exit(1)
    backup_interval_hours = int(os.environ.get("N"))
    while True:
        backup_database()
        remove_old_backups()
        time.sleep(backup_interval_hours * 3600)
