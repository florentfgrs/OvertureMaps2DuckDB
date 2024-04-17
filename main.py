#!/usr/bin/env python3

import configparser
from toolbelt.duckdb_database_handling import database_exists, create_database, execute_query_on_db
from pathlib import Path
import duckdb

# Config 
config = configparser.ConfigParser()
config.read("config.ini")

# Get db_path
db_path = Path(config["DuckDB"]["db_path"])

# Overtures maps
release = Path(config["OverturesMaps"]["release"])
xmin = Path(config["OverturesMaps"]["xmin"])
xmax = Path(config["OverturesMaps"]["xmax"])
ymin = Path(config["OverturesMaps"]["ymin"])
ymax = Path(config["OverturesMaps"]["ymax"])


# Create database if not exists 
if not database_exists(db_path): 
    create_database(db_path)

# Install needed extension in database 
sql = ("INSTALL spatial ; INSTALL httpfs ;")
execute_query_on_db(sql, db_path)

# Download OverturesMaps data 
with open("sql/places.sql", "r") as file:
    sql_script = file.read()
    sql_script = sql_script.format(millesime=release, xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax)

execute_query_on_db(sql_script, db_path)
