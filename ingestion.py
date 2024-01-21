"""Module to ingest the data into local database."""
import argparse
from time import time
from typing import Generator

import pandas as pd
from pandas import DataFrame
from sqlalchemy import Engine, create_engine


def read_data(url: str) -> Generator[DataFrame, None, None]:
    """_summary_

    Args:
        url (str): _description_

    Yields:
        Generator[DataFrame]: _description_
    """
    yield from pd.read_csv(url, iterator=True, chunksize=100000)


def clean_data(df: DataFrame) -> DataFrame:
    """_summary_

    Args:
        df (DataFrame): _description_

    Returns:
        DataFrame: _description_
    """
    df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
    df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)


def write_data(df: DataFrame, con: Engine, table_name: str) -> None:
    """_summary_

    Args:
        df (DataFrame): _description_
        con (Engine): _description_
        table_name (str): _description_
    """
    df.to_sql(table_name, con, if_exists="append")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Ingest CSV data to Postgres")

    parser.add_argument("--user", required=True, help="user name for postgres")
    parser.add_argument("--password", required=True, help="password for postgres")
    parser.add_argument("--host", required=True, help="host for postgres")
    parser.add_argument("--port", required=True, help="port for postgres")
    parser.add_argument("--db", required=True, help="database name for postgres")
    parser.add_argument(
        "--table_name",
        required=True,
        help="name of the table where we will write the results to",
    )
    parser.add_argument("--url", required=True, help="url of the csv file")

    args = parser.parse_args()

    engine = create_engine(
        f"postgresql://{args.user}:{args.password}@{args.host}:{args.port}/{args.db}"
    )

    ingest_data = (clean_data(df_raw) for df_raw in read_data(args.url))
    for df_clean in ingest_data:
        t_start = time()
        write_data(df_clean, engine, args.table_name)
        t_end = time()
        print(f"inserted another chunk, took {(t_end - t_start):.3f}")
