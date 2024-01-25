-- How many taxi trips were totally made on September 18th 2019?
select count(*)
from green_taxi_trips
where
  true
  and lpep_pickup_datetime::date = '2019-09-18'
  and lpep_dropoff_datetime::date = '2019-09-18';

-- Answer: 15612

-- Which was the pick up day with the largest trip distance
-- Use the pick up time for your calculations.
select
  lpep_pickup_datetime::date as pickup_day
  coalesce(sum(trip_distance), 0) as total_trip_distance
from green_taxi_trips
group by 1
order by 2 DESC
limit 1;

-- Answer: 2019-09-26

-- Which are the three biggest pick up Boroughs that had a sum of total_amount superior to 50000?
-- Consider lpep_pickup_datetime in '2019-09-18' and ignoring Borough has Unknown
select
  pu_zones."Borough" as pickup_borough
  , coalesce(sum(trips.total_amount), 0) as total_amount
from green_taxi_trips as trips
left join taxi_zones as pu_zones
  on pu_zones."LocationID" = trips."PULocationID"
where
  true
  and pu_zones."Borough" <> 'Unknown'
  and trips.lpep_pickup_datetime::date = '2019-09-18'
group by 1
having sum(trips.total_amount) > 50000
order by 2 desc
limit 3;

-- Answer: "Brooklyn" "Manhattan" "Queens"

-- For the passengers picked up in September 2019 in the zone name Astoria
-- which was the drop off zone that had the largest tip? We want the name of the zone, not the id.
select
  do_zones."Zone" as dropoff_zone
  , coalesce(max(trips.tip_amount), 0) as tips_amount
from green_taxi_trips as trips
left join taxi_zones as do_zones
  on do_zones."LocationID" = trips."DOLocationID"
left join taxi_zones as pu_zones
  on pu_zones."LocationID" = trips."PULocationID"
where
  true
  and pu_zones."Zone" = 'Astoria'
  and date_trunc('month', trips.lpep_pickup_datetime) = '2019-09-01'
group by 1
order by 2 desc
limit 1;

-- Answer: 'JFK Airport'