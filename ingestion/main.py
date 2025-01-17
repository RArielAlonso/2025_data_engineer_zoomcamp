import pandas as pd
from sqlalchemy import create_engine
from time import time

conn_str='postgresql://aalonso:aalonso@postgres-db:5432/database_nyc'
engine=create_engine(conn_str)
df_iter1=pd.read_csv("/tmp/green_tripdata_2019-10.csv",iterator=True,chunksize=100000)
df_zone=pd.read_csv("/tmp/taxi_zone_lookup.csv",iterator=True,chunksize=100000)


def main():
   while True:
    try:
        t_start_time=time()
        df=next(df_iter1)
        df['lpep_pickup_datetime']=pd.to_datetime(df['lpep_pickup_datetime'])
        df['lpep_dropoff_datetime']=pd.to_datetime(df['lpep_dropoff_datetime'])
        df.to_sql(name='nyc_table', con=engine, if_exists='append', index=False)
        t_end_time=time()
        print("Inserting df it took %.3f second" %(t_end_time-t_start_time))
        df_zone=pd.read_csv("/tmp/taxi_zone_lookup.csv")
        df_zone.to_sql(name='zones_taxi', con=engine, if_exists='replace', index=False)
    
    except StopIteration:
       print("Finished the loading data to postgres")
       break

if __name__ == "__main__":
    main()