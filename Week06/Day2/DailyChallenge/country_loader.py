import requests
import random

import psycopg2
import os

from pathlib import Path

env_path = Path(__file__).resolve().parent / ".env"
if env_path.exists():
    with open(env_path) as f:
        for line in f:
            if "=" in line and not line.startswith("#"):
                key, value = line.strip().split("=", 1)
                os.environ[key] = value

url = "https://restcountries.com/v3.1/all"
response = requests.get(url) #this contacts the API to request the data
countries = response.json()#extracts the data in json formatting

selected_countries = random.sample(countries, 10)

for country in selected_countries:
    name = country.get("name", {}).get("common")
    capital = country.get("capital", [None])[0]
    flag = country.get("flags", {}).get("png")
    subregion = country.get("subregion")
    population = country.get("population")

    conn = psycopg2.connect(
        dbname=os.environ.get("DB_NAME"),
        user=os.environ.get("DB_USER"),
        password=os.environ.get("DB_PASSWORD"),
        host=os.environ.get("DB_HOST"),
        port=os.environ.get("DB_PORT")
    )
    cur = conn.cursor()

    cur.execute("""
        INSERT INTO countries (name, capital, flag, subregion, population)
        VALUES (%s, %s, %s, %s, %s)
    """, (name, capital, flag, subregion, population))

    conn.commit()
    cur.close()
    conn.close()




