from pathlib import Path
import logging
from toolbelt.config_logging import *
import duckdb

def database_exists(db_path:Path)-> bool:
    """Check if the database already exists

    :param db_path: Database path
    :type db_path: Path
    """
    if db_path.exists() : 
        logging.info("The base already exists, no new base will be created.")
    return db_path.exists()

def create_database(db_path:Path)-> None:
    """Create database

    :param db_path: Database path
    :type db_path: Path
    """
    try :
        connection = duckdb.connect(str(db_path))
        connection.close()
        logging.info(f"{db_path} database has been created.")
    except Exception as e : 
        logging.error(e)

def execute_query_on_db(sql:str, db_path:Path)-> None:
    """Execute SQL query on database

    :param sql: SQL Query
    :type sql: str
    :param db_path: Database path
    :type db_path: Path
    """
    connection = duckdb.connect(str(db_path))
    try :
        connection.sql(sql)
    except Exception as e : 
        logging.error(e)
    connection.close()

