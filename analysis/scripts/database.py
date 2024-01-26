import os
import logging
import psycopg2

from dotenv import load_dotenv
from contextlib import contextmanager
from logger import set_logger

logger = set_logger("database")

class Database:

    def __init__(self):
        load_dotenv()
        self.db_params = {
            'dbname': os.getenv('DB_NAME'),
            'user': os.getenv('DB_USER'),
            'password': os.getenv('DB_PASS'),
            'host': os.getenv('DB_HOST'),
            'port': os.getenv('DB_PORT')
        }
        logger.info("Database object initialized")

    @contextmanager
    def get_connection(self):
        # '**': unpacks the dictionary into keyword arguments
        logger.debug("Connecting to database")
        conn = psycopg2.connect(**self.db_params)
        try:
            yield conn # yield is like return, but for generators 
            # (excution is paused and resumed witin a 'with' block)
        finally:
            conn.close()
            logger.info("Disconnected from database")

    def execute_query(self, query, params=None):
        # excutes single query
        with self.get_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute(query, params)
                conn.commit()

    def execute_queries(self, queries):
        # executes multiple queries (good for batch operations)
        with self.get_connection() as conn:
            with conn.cursor() as cursor:
                for query in queries:
                    if query.strip():
                        cursor.execute(query)
                        print(cursor.statusmessage)
                conn.commit()
                logger.debug("Executed queries")
    
    def read_sql(self, filepath):
        # read multiple queries from sql files
        with open(filepath, 'r') as file:
            file_content = file.read() # read file contents
            queries = file_content.split(';') # split into individual queries
    
            # strip whitespace from each query and return list of queries
            return [query.strip() for query in queries if query.strip()] 
