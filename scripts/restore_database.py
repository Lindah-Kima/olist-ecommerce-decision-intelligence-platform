import os
import subprocess
from dotenv import load_dotenv
from pathlib import Path

load_dotenv(dotenv_path=Path(__file__).resolve().parent.parent / ".env")

host = os.getenv("DB_HOST")
port = os.getenv("DB_PORT")
database = os.getenv("DB_DATABASE")
user = os.getenv("DB_USERNAME")
password = os.getenv("DB_PASSWORD").strip('"')

env = os.environ.copy()
env["PGPASSWORD"] = password

backup_file = input("Enter backup file path (.sql): ")

schema = input("Enter schema name (bronze/silver/gold): ")

print(f"Restoring {schema} from {backup_file}...")

subprocess.run(
    [
        "psql",
        "-h", host,
        "-p", port,
        "-U", user,
        "-d", database,
        "-f", backup_file
    ],
    env=env,
    check=True
)

print("Restore completed successfully.")