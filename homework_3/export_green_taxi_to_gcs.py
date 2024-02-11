import pyarrow as pa
from pandas import DataFrame
import os

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "/home/src/personal-gcp.json/my-creds.json"

bucket_name = "mage-zoomcamp-enrique-perez"
project_id = "arcane-attic-412509"
table_name = "ny_green_taxi_2022"
root_path = f"{bucket_name}/{table_name}"

@data_exporter
def export_data_to_google_cloud_storage(df: DataFrame, **kwargs) -> None:
    """
    Template for exporting data to a Google Cloud Storage bucket.
    Specify your configuration settings in `io_config.yaml`.

    Docs: https://docs.mage.ai/design/data-loading#googlecloudstorage
    """
    df["lpep_pickup_date"] = df["lpep_pickup_datetime"].dt.date

    table = pa.Table.from_pandas(df)

    gcs = pa.fs.GcsFileSystem()

    pa.parquet.write_to_dataset(
        table,
        root_path=root_path,
        partition_cols=["lpep_pickup_date"],
        filesystem=gcs
    )

