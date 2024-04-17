from pathlib import Path

import duckdb

def database_exists(db_path:Path):
    return db_path.exists()

def create_database(db_path:Path):
    connection = duckdb.connect(str(db_path))
    connection.close()

def execute_query_on_db(sql:str, db_path:Path):
    connection = duckdb.connect(str(db_path))
    try :
        connection.sql(sql)
    except Exception as e : 
        print(e)
    connection.close()
