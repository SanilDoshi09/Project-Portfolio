import os
import logging

from logger import set_logger
from database import Database

logger = set_logger("main")

# create sql tables from schema.sql file
def create_tables(db):
    filepath = '/usr/src/server/database/schema.sql'
    queries = db.read_sql(filepath)
    logger.debug("Read schema.sql file")

    db.execute_queries(queries)

def main():
    db = Database()
    logger.debug("Created database object")

if __name__ == "__main__":
    main()