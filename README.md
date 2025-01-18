# 2025 Data Engineer Zoomcamp

## Homework 1

- Download the csv file

``` 
wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-10.csv.gz
```

- Command to run docker compose
```
docker compose up
```

- Command to create tables inside the container of the database or recreate the tables
```
docker exec -it postgres-db bash /usr/local/bin/data_tables.sh
```

- Command to get inside the container
```
docker exec -it postgres-db psql -d database_nyc -U aalonso
```

- Command to build the image of python (get inside the folder first)
```
cd /ingesition

docker build -t ingestion .
```

- Command to run python ingestion inside the container

First you must download the file with the comand wget inside the folder /tmp/ and after that make gunzip from the file to extract the csv from the .gz file 
```
docker run -it --rm --network nt-nyc -v /tmp:/tmp ingestion 
```

- Question 3
```
select case when trip_distance<=1 then 'Up to 1 mile'
			when trip_distance>1 and trip_distance<=3 then '1-3'
			when trip_distance>3 and trip_distance<=7 then '3-7'
			when trip_distance>7 and trip_distance<=10 then '7-10'
			else '>10' end group_trip_distance,
			count(trip_distance)
from public.nyc_table
where lpep_pickup_datetime between '2019-10-01' and '2019-11-01'
and lpep_dropoff_datetime between '2019-10-01' and '2019-11-01'
group by group_trip_distance
;
```
