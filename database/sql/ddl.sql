create schema public;

drop table if exists public.nyc_table;

CREATE TABLE public.nyc_table (
  "VendorID" REAL,
  "lpep_pickup_datetime" TIMESTAMP,
  "lpep_dropoff_datetime" TIMESTAMP,
  "store_and_fwd_flag" TEXT,
  "RatecodeID" REAL,
  "PULocationID" INTEGER,
  "DOLocationID" INTEGER,
  "passenger_count" REAL,
  "trip_distance" REAL,
  "fare_amount" REAL,
  "extra" REAL,
  "mta_tax" REAL,
  "tip_amount" REAL,
  "tolls_amount" REAL,
  "ehail_fee" REAL,
  "improvement_surcharge" REAL,
  "total_amount" REAL,
  "payment_type" REAL,
  "trip_type" REAL,
  "congestion_surcharge" REAL
)