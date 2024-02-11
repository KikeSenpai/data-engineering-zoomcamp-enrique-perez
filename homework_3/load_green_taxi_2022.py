import pandas as pd

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data(*args, **kwargs) -> pd.DataFrame:
    """
    Template for loading data from API
    """
    base_url = "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022"

    months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    return pd.concat([pd.read_parquet(f"{base_url}-{month}.parquet") for month in months])

@test
def test_output(output: pd.DataFrame, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'

