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
select case when trip_distance<=1 then '1- Up to 1 mile'
			when trip_distance>1 and trip_distance<=3 then '2 - 1-3 miles'
			when trip_distance>3 and trip_distance<=7 then '3 - 3-7 miles'
			when trip_distance>7 and trip_distance<=10 then '4 - 7-10 miles'
			else '5 - >10' end group_trip_distance,
			count(trip_distance)
from public.nyc_table
where lpep_pickup_datetime >= '2019-10-01' 
and lpep_dropoff_datetime < '2019-11-01'
group by group_trip_distance
order by group_trip_distance ASC
;
```

- Question 4
```
select date(lpep_pickup_datetime),trip_distance from public.nyc_table
order by trip_distance DESC
limit 1;
```

- Question 5
```
select t."Zone",sum(total_amount) as total from public.nyc_table n
join public.zones_taxi t on t."LocationID"=n."PULocationID"
where lpep_pickup_datetime between '2019-10-18' and '2019-10-19'
group by t."Zone"
having sum(total_amount)>=13000
order by total DESC;
```

- Question 6
```
select d."Zone" as "Dropoff Location",t."Zone", n."tip_amount",lpep_pickup_datetime from public.nyc_table n
join public.zones_taxi t on t."LocationID"=n."PULocationID"
join public.zones_taxi d on d."LocationID"=n."DOLocationID"
where t."Zone"='East Harlem North'
and lpep_pickup_datetime>= '2019-10-01' and lpep_pickup_datetime<'2019-11-01'
order by n."tip_amount" DESC
limit 1;
```

## Homework 2

I have used the flow of Kestra called ***zoomcamp.02_postgres_taxi*** with a local postgres database called ***database_nyc*** created by docker compose

- Question 1

The file size is:

***128.3 MB***

![hw2_question1](/images/hw2_question1.png)

- Question 2

The render name is

***green_tripdata_2020-04.csv***

![hw2_question2](/images/hw2_question2.png)

- Question 3

The number of rows for 2020 yellow data is:

***24.648.499***

```
SELECT count(*)
	FROM public.yellow_tripdata
where filename like 'yellow_tripdata_2020%';
```

- Question 4

The number of rows for 2020 green data is:

***1,734,051***

```
SELECT count(*)
	FROM public.green_tripdata
where filename like 'green_tripdata_2020%';
```

- Question 5

The number of rows for 2021 Marche Yellow data is:

***1.925.152***

```
SELECT count(*)
	FROM public.yellow_tripdata
where filename like 'yellow_tripdata_2021-03%';
```

- Question 6

![hw2_question6](/images/hw2_question6.jpg)


https://kestra.io/docs/workflow-components/triggers/schedule-trigger


## Homework 3

#### CREATE RESOURCES WITH TERRAFORM
- First you will need to create the service account and login with the  [***gcloud auth login***](https://cloud.google.com/docs/authentication/gcloud?hl=es-419)
```
terraform init
terraform plan
terraform apply
```

Then push the data from the urls to the buckets with this command, *you may need to install some libraries*
```
python load_to_gcs/to_gcs.py 
```

- Creating external tables

```
CREATE OR REPLACE EXTERNAL TABLE terrademo_dataset.yellow_taxi_2024
OPTIONS
(
  format='PARQUET',
  uris=['gs://data-engineer-zoomcamp-450513-data-lake-bucket/*.parquet']
);
```
- Creating the materialized table
```
CREATE OR REPLACE TABLE terrademo_dataset.yellow_taxi_2024_not_parti AS
select * from terrademo_dataset.yellow_taxi_2024;
```

- Question 1

***20.332.093 records ***
```
select count(*) from `terrademo_dataset.yellow_taxi_2024`;
```

- Question 2

***0 MB for the External Table and 155.12 MB for the Materialized Table***
```
select distinct PULocationID from `terrademo_dataset.yellow_taxi_2024`;

select distinct PULocationID from `terrademo_dataset.yellow_taxi_2024_not_parti`;
```
-  Question 3

***BigQuery is a columnar database, and it only scans the specific columns requested in the query. Querying two columns (PULocationID, DOLocationID) requires reading more data than querying one column (PULocationID), leading to a higher estimated number of bytes processed.***
```
select PULocationID,DOLocationID  from `terrademo_dataset.yellow_taxi_2024_not_parti`;
```

- Question 4

***8,333 records***

```
select count(*) from `terrademo_dataset.yellow_taxi_2024_not_parti`
where fare_amount=0;
```

- Question 5

***Partition by tpep_dropoff_datetime and Cluster on VendorID***

```
CREATE OR REPLACE TABLE `terrademo_dataset.yellow_taxi_2024_parti_clust`
PARTITION BY date(tpep_dropoff_datetime)
CLUSTER BY VendorID
AS
select * from terrademo_dataset.yellow_taxi_2024;
```

- Question 6

***310,24 MB***
```
select distinct VendorID from `terrademo_dataset.yellow_taxi_2024_not_parti`
where tpep_dropoff_datetime between '2024-03-01' and '2024-03-15';
```

***26,84 MB***
```
select distinct VendorID from `terrademo_dataset.yellow_taxi_2024_parti_clust`
where tpep_dropoff_datetime between '2024-03-01' and '2024-03-15';
```