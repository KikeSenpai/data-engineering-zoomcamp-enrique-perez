WITH max_avg AS (
  SELECT MAX(avg_trip_duration) AS max_avg_duration
  FROM trip_duration
)
, pu_do_zones AS (
  SELECT
    trip_duration.pu_zone,
    trip_duration.do_zone
  FROM max_avg, trip_duration
  WHERE trip_duration.avg_trip_duration = max_avg.max_avg_duration
)
SELECT COUNT(trip_duration.avg_trip_duration) AS trip_count
FROM pu_do_zones, trip_duration
WHERE
  pu_do_zones.pu_zone = trip_duration.pu_zone
  AND pu_do_zones.do_zone = trip_duration.do_zone;
