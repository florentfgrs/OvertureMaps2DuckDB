# OverturesMaps2DuckDB

The aim of this project is to provide scripts and tools to easily retrieve data from OverturesMaps into a DuckDB database on a given right-of-way.

# How to use ?

## 🛠️ Create venv and install dependencies

```bash
python -m venv .venv 
source .venv/bin/activate
python -m pip install -r requirements.txt
```

## 📝 Complete the parameters in config.ini

These are :

- The desired bbox
- The database path
- Release of data to be used

## 🚀 Run the script

All overtures maps data on the chosen bbox will be uploaded to the database.

```bash
main.py
```