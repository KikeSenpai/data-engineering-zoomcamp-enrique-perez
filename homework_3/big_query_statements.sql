CREATE OR REPLACE EXTERNAL TABLE
  `arcane-attic-412509.ny_taxi.green_trips_2022`
WITH PARTITION COLUMNS OPTIONS (
  format = 'PARQUET',
  uris = ['gs://mage-zoomcamp-enrique-perez/ny_green_taxi_2022/*'],
  hive_partition_uri_prefix = 'gs://mage-zoomcamp-enrique-perez/ny_green_taxi_2022',
  require_hive_partition_filter = FALSE );


CREATE OR REPLACE TABLE
  `arcane-attic-412509.ny_taxi.green_trips_2022_bq` AS (
  SELECT
    *
  FROM
    `arcane-attic-412509.ny_taxi.green_trips_2022` );


SELECT
  COUNT(*)
FROM
  `arcane-attic-412509.ny_taxi.green_trips_2022`;


SELECT
  COUNT(DISTINCT PULocationID)
FROM
  `arcane-attic-412509.ny_taxi.green_trips_2022`;


SELECT
  COUNT(DISTINCT PULocationID)
FROM
  `arcane-attic-412509.ny_taxi.green_trips_2022_bq`;


SELECT
  COUNT(*)
FROM
  `arcane-attic-412509.ny_taxi.green_trips_2022_bq`
WHERE
  fare_amount = 0 ;

    
CREATE OR REPLACE TABLE
  `arcane-attic-412509.ny_taxi.green_trips_2022_bq_partitioned_clustered`
PARTITION BY
  lpep_pickup_date
CLUSTER BY
  PULocationID AS (
  SELECT
    *
  FROM
    `arcane-attic-412509.ny_taxi.green_trips_2022_bq` );


SELECT 
  COUNT(*)
FROM
   `arcane-attic-412509.ny_taxi.green_trips_2022_bq_partitioned_clustered` ;

