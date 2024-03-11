WITH max_avg AS (
  SELECT MAX(avg_trip_duration) AS max_avg_duration
  FROM trip_duration
)
SELECT trip_duration.*
FROM max_avg, trip_duration
WHERE trip_duration.avg_trip_duration = max_avg.max_avg_duration;