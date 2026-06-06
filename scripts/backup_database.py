from pathlib import Path
from dotenv import load_dotenv
import os
import subprocess
from datetime import datetime
import gzip
import shutil

# ----------------------------
# Load environment variables
# ----------------------------
load_dotenv(dotenv_path=Path(__file__).resolve().parent.parent / ".env")

host = os.getenv("DB_HOST")
port = os.getenv("DB_PORT")
database = os.getenv("DB_DATABASE")
user = os.getenv("DB_USERNAME")
password = os.getenv("DB_PASSWORD").strip('"')

# ----------------------------
# Schemas to back up
# ----------------------------
schemas = ["bronze", "silver", "gold"]

# Date stamp for versioning backups
today = datetime.now().strftime("%Y-%m-%d")

# Set password for pg_dump authentication
env = os.environ.copy()
env["PGPASSWORD"] = password

# ----------------------------
# Logging setup
# ----------------------------
log_file = Path("backups/backup_log.txt")

def write_log(message: str):
    """Append logs to a file with timestamps."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open(log_file, "a") as f:
        f.write(f"[{timestamp}] {message}\n")

# ----------------------------
# Backup + Compress function
# ----------------------------
def backup_schema(schema: str):
    """Back up a single PostgreSQL schema and compress it."""

    try:
        # Raw backup file (uncompressed)
        backup_file = Path(f"backups/{schema}_backup_{today}.sql")

        print(f"Backing up {schema} schema...")
        write_log(f"START backup for {schema}")

        # Run pg_dump for specific schema
        subprocess.run(
            [
                "pg_dump",
                "-h", host,
                "-p", port,
                "-U", user,
                "-d", database,
                "-n", schema,
                "-f", str(backup_file)
            ],
            env=env,
            check=True
        )

        print(f"Backup created: {backup_file}")
        write_log(f"SUCCESS backup for {schema}")

        # ----------------------------
        # Compress the backup file
        # ----------------------------
        compressed_file = backup_file.with_suffix(".sql.gz")

        with open(backup_file, "rb") as f_in:
            with gzip.open(compressed_file, "wb") as f_out:
                shutil.copyfileobj(f_in, f_out)

        print(f"Compressed: {compressed_file}")
        write_log(f"COMPRESSED backup for {schema}")

        # Optional: remove uncompressed file to save space
        os.remove(backup_file)

        print(f"Cleaned up raw file for {schema}")

    except subprocess.CalledProcessError as e:
        write_log(f"ERROR backup failed for {schema}: {str(e)}")
        print(f"❌ Backup failed for {schema}")

    except Exception as e:
        write_log(f"GENERAL ERROR for {schema}: {str(e)}")
        print(f"Unexpected error for {schema}")

# ----------------------------
# Main execution loop
# ----------------------------
if __name__ == "__main__":
    write_log("=== BACKUP JOB STARTED ===")

    for schema in schemas:
        backup_schema(schema)

    write_log("=== BACKUP JOB COMPLETED ===")
    print("\nAll schema backups completed successfully.")