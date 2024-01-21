# Define variables
APP_NAME=taxi_ingest
APP_TAG=v1.0
USER=kike
PASSWORD=17173306
HOST=pg-database
PORT=5432
DB=ny_taxi

# Build containerized project
build:
	docker build -t ${APP_NAME}:${APP_TAG} .

# Ingest green taxi
ingest-green-taxi-trips:
	docker run -it ${APP_NAME}:${APP_TAG} \
		--user=${USER} \
		--password=${PASSWORD} \
		--host=${HOST} \
		--port=${PORT} \
		--db=${DB} \
		--table_name=green_taxi_trips \
		--url=https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-09.csv.gz

# Ingest
ingest-taxi_zones:
	docker run -it ${APP_NAME}:${APP_TAG} \
		--user=${USER} \
		--password=${PASSWORD}, \
		--host=${HOST} \
		--port=${PORT} \
		--db=${DB} \
		--table_name=taxi_zones \
		--url=https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv
