"""DuckDB handling"""

from pathlib import Path
import time
import duckdb
from toolbelt.config_logging import logging
from toolbelt.loader import Loader


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

def execute_query_on_db(sql:str, db_path:Path, query_name)-> None:
    """Execute SQL query on database

    :param sql: SQL Query
    :type sql: str
    :param db_path: Database path
    :type db_path: Path
    """

    start_time = time.time()
    logging.info(f"Start : {query_name}")

    loader = Loader("Execution in progress...", "Execution completed !", 0.05).start()
    try:
        with duckdb.connect(str(db_path)) as con:
            con.execute(sql)
    except Exception as e:
        logging.error(e)
    loader.stop()

    end_time = time.time()
    elapsed_time = end_time - start_time
    logging.info(f"During {round(elapsed_time, 2)} sec")

def install_load_extension(db_path:Path) -> None:
    """Install and load the needed extension 

    :param db_path: _description_
    :type db_path: Path
    """
    sql = ("FORCE INSTALL spatial FROM 'http://nightly-extensions.duckdb.org' ;"
           "INSTALL httpfs ; LOAD spatial ; LOAD httpfs ; ")
    execute_query_on_db(sql, db_path, "Install extension")
