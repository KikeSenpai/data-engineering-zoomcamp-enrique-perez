WITH latest_pu_time AS (
  SELECT MAX(tpep_pickup_datetime) AS max_pu_time
  FROM trip_data
)
SELECT
  pu_zone.Zone AS pu_zone,
  COUNT(trip_data.tpep_pickup_datetime) AS trip_count
FROM latest_pu_time, trip_data
JOIN taxi_zone AS pu_zone
  ON trip_data.PULocationID = pu_zone.location_id
WHERE
  trip_data.tpep_pickup_datetime IS NOT NULL
  AND trip_data.tpep_pickup_datetime BETWEEN latest_pu_time.max_pu_time - INTERVAL '17 hours' AND latest_pu_time.max_pu_time
GROUP BY 1
ORDER BY 2 DESC;