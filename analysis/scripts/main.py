import os
import logging

from logger import set_logger

def main():
    # set logger
    logger = set_logger("main")
    
    logger.info("testing")
    print("testing")

if __name__ == "__main__":
    main()