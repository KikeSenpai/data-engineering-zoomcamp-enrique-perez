if "transformer" not in globals():
    from mage_ai.data_preparation.decorators import transformer
if "test" not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    """
    Template code for a transformer block.
    """
    column_mapping = {
        "VendorID": "vendor_id",
        "RatecodeID": "rate_code_id",
        "PULocationID": "pu_location_id",
        "DOLocationID": "do_location_id",
    }

    passenger_count_not_zero = data["passenger_count"] != 0
    trip_distance_not_zero = data["trip_distance"] != 0
    keep_valid_data = passenger_count_not_zero & trip_distance_not_zero

    return (
        data[(keep_valid_data)]
        .rename(columns=column_mapping)
        .assign(lpep_pickup_date=lambda row: row["lpep_pickup_datetime"].dt.date)
    )


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, "The output is undefined"
    assert output["vendor_id"].isin([1, 2]).sum() > 0, "Invalid vendor_id detected"
    assert output["passenger_count"].isin([0]).sum() == 0, "Passenger count must be greater than 0"
    assert output["trip_distance"].isin([0]).sum() == 0, "Trip distance must be greater than 0"
