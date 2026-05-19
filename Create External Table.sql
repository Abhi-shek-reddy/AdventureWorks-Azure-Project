

CREATE DATABASE SCOPED CREDENTIAL cred_abhi
WITH 
    IDENTITY='Managed Identity'

CREATE EXTERNAL DATA SOURCE source_silver
WITH
(
    LOCATION='abfss://silver@awstroagedatalakeabhi.dfs.core.windows.net',
    CREDENTIAL = cred_abhi  
)
CREATE EXTERNAL DATA SOURCE source_gold
WITH
(
    LOCATION='abfss://gold@awstroagedatalakeabhi.dfs.core.windows.net',
    CREDENTIAL = cred_abhi  
)

CREATE EXTERNAL FILE FORMAT format_parquet
WITH
(
    FORMAT_TYPE=PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
)

CREATE EXTERNAL TABLE gold.extsales
WITH(
    LOCATION='extsales',
    DATA_SOURCE=source_gold,
    FILE_FORMAT=format_parquet
)
AS
select * from gold.sales

select * from gold.extsales