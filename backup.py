import os
import time
import shutil


def backup_database():
    dbname = os.environ.get("POSTGRES_DB")
    dbuser = os.environ.get("POSTGRES_USER")
    dbpassword = os.environ.get("POSTGRES_PASSWORD")
    backup_dir = os.environ.get("BACKUP_DIR")
    timestamp = time.strftime('%Y-%m-%d_%H-%M-%S')
    backup_filename = f"{timestamp}_{dbname}.sql"
    backup_command = f"pg_dump -U {dbuser} -d {dbname} > {backup_dir}/{backup_filename}"
    print("Backing up database...")
    os.system(backup_command)
    print("Backing up finished")


def remove_old_backups():
    backup_dir = os.environ.get("BACKUP_DIR")
    max_backups = int(os.environ.get("M"))
    backups = sorted(os.listdir(backup_dir))
    while len(backups) > max_backups:
        oldest_backup = backups.pop(0)
        os.remove(os.path.join(backup_dir, oldest_backup))


def load_dotenv():
    with open(".env") as f:
        for line in f:
            key, value = line.strip().split("=")
            os.environ[key] = value


if __name__ == "__main__":
    load_dotenv()
    backup_interval_hours = int(os.environ.get("N"))
    while True:
        backup_database()
        remove_old_backups()
        time.sleep(backup_interval_hours * 3600)
