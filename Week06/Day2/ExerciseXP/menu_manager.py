import os
import psycopg2
from pathlib import Path
from menu_item import MenuItem

# Load environment variables
env_path = Path(__file__).resolve().parent / ".env"
if env_path.exists():
    with open(env_path) as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith("#") and "=" in line:
                key, value = line.split("=", 1)
                os.environ[key] = value

class MenuManager:
    @classmethod
    def get_by_name(cls, name):
        conn = psycopg2.connect(
            dbname=os.environ.get("DB_NAME"),
            user=os.environ.get("DB_USER"),
            password=os.environ.get("DB_PASSWORD"),
            host=os.environ.get("DB_HOST"),
            port=os.environ.get("DB_PORT")
        )
        cur = conn.cursor()
        cur.execute("SELECT item_name, item_price FROM Menu_Items WHERE item_name = %s", (name,))
        item = cur.fetchone()
        cur.close()
        conn.close()

        return MenuItem(item[0], item[1]) if item else None

    @classmethod
    def all_items(cls):
        conn = psycopg2.connect(
            dbname=os.environ.get("DB_NAME"),
            user=os.environ.get("DB_USER"),
            password=os.environ.get("DB_PASSWORD"),
            host=os.environ.get("DB_HOST"),
            port=os.environ.get("DB_PORT")
        )
        cur = conn.cursor()
        cur.execute("SELECT item_name, item_price FROM Menu_Items")
        items_data = cur.fetchall()
        cur.close()
        conn.close()

        return [MenuItem(name, price) for name, price in items_data]
