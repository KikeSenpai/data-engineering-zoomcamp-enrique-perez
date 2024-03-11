CREATE MATERIALIZED VIEW trip_duration AS
  WITH trip_duration AS (
    SELECT
      pu_zone.Zone AS pu_zone,
      do_zone.Zone AS do_zone,
      EXTRACT(EPOCH FROM (trip.tpep_dropoff_datetime - trip.tpep_pickup_datetime)) / 60 AS trip_duration_mins
    FROM trip_data AS trip
    JOIN taxi_zone AS pu_zone
      ON trip.PULocationID = pu_zone.location_id
    JOIN taxi_zone AS do_zone
      ON trip.DOLocationID = do_zone.location_id
  )
  SELECT
    pu_zone,
    do_zone,
    MIN(trip_duration_mins) AS min_trip_duration,
    MAX(trip_duration_mins) AS max_trip_duration,
    AVG(trip_duration_mins) AS avg_trip_duration
  FROM trip_duration
  GROUP BY 1, 2;