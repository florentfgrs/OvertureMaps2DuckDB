"""Main script."""

#!/usr/bin/env python3

import configparser
from pathlib import Path

from toolbelt.duckdb_database_handling import (
    database_exists, create_database,
    execute_query_on_db,
    install_load_extension
)

# Config
config = configparser.ConfigParser()
config.read("config.ini")

# Get db_path
db_path = Path(config["DuckDB"]["db_path"])

# Overture maps
release = Path(config["OvertureMaps"]["release"])
xmin = Path(config["OvertureMaps"]["xmin"])
xmax = Path(config["OvertureMaps"]["xmax"])
ymin = Path(config["OvertureMaps"]["ymin"])
ymax = Path(config["OvertureMaps"]["ymax"])


# Create database if not exists
if not database_exists(db_path):
    create_database(db_path)


# Install needed extension in database
install_load_extension(db_path)


for table in ['admins', 'places', 'buildings', 'transportation'] :
    # Download OvertureMaps data
    with open(f"sql/{table}.sql", "r", encoding="utf-8") as file:
        sql_script = file.read()
        sql_script = sql_script.format(millesime=release,
                                       xmin=xmin,
                                       xmax=xmax,
                                       ymin=ymin,
                                       ymax=ymax
                                       )

    execute_query_on_db(sql_script, db_path, f"Download {table}")
g