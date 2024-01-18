import os
import logging

from logger import set_logger
from database import Database

def main():
    # set logger
    logger = set_logger("main")
    
    logger.info("Creating database object")

    db = Database()
    db.get_connection()

if __name__ == "__main__":
    main()