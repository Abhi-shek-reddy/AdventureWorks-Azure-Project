# AdventureWorks Azure Data Engineering Project

An end-to-end data engineering pipeline built on Microsoft Azure, implementing the Medallion Architecture (Bronze, Silver, Gold) to transform raw CSV data from GitHub into business-ready reports in Power BI.

---

## Project Overview

This project demonstrates a complete data engineering workflow covering data ingestion, transformation, storage, and reporting using industry-standard Azure cloud services. The pipeline is designed to be dynamic, scalable, and follows best practices in modern data engineering.

---

## Architecture

```
Source (GitHub CSV Files)
          |
          | Azure Data Factory - Dynamic Pipeline
          |
    Bronze Layer (Azure Data Lake Gen2)
    Raw CSV files stored as-is
          |
          | Azure Databricks - PySpark Transformations
          |
    Silver Layer (Azure Data Lake Gen2)
    Cleaned and transformed Parquet files
          |
          | Azure Synapse Analytics - SQL Views and External Tables
          |
    Gold Layer (Azure Data Lake Gen2)
    Business-ready aggregated data
          |
          | Power BI
          |
    Reports and Dashboards
```

---

## Technologies Used

| Technology | Purpose |
|---|---|
| Azure Data Factory | Data ingestion and pipeline orchestration |
| Azure Data Lake Gen2 | Scalable cloud storage for all data layers |
| Azure Databricks | PySpark-based data transformation |
| Apache Spark | Distributed data processing |
| Delta Lake | Reliable data storage format with ACID transactions |
| Azure Synapse Analytics | SQL-based data analysis and Gold layer creation |
| Power BI | Business intelligence and reporting |

---

## Dataset

The AdventureWorks dataset contains the following tables:

| Table | Description |
|---|---|
| Sales 2015, 2016, 2017 | Transaction-level sales data across three years |
| Customers | Customer demographic and location information |
| Products | Product details including category and pricing |
| Product Categories | High-level product categorization |
| Product Subcategories | Granular product categorization |
| Calendar | Date dimension table |
| Territories | Geographic sales territory information |
| Returns | Product return records |

---

## Data Pipeline

### Bronze Layer - Data Ingestion

- Built a dynamic Azure Data Factory pipeline using Lookup, ForEach, and Copy Activity
- Created a JSON configuration file listing all source files with their GitHub paths and destination folder names
- Used HTTP Linked Service to connect to GitHub raw content
- Used Azure Data Lake Gen2 Linked Service as the sink
- All raw CSV files stored in the bronze container without modification

### Silver Layer - Data Transformation

- Connected Azure Databricks to Azure Data Lake using OAuth authentication
- Loaded all CSV files into PySpark DataFrames
- Applied the following transformations:
  - Fixed incorrect data types using cast and to_timestamp functions
  - Handled null and missing values using replacement logic
  - Standardized column values using when and otherwise conditions
  - Created derived columns such as full name from first and last name
  - Combined Sales 2015, 2016, and 2017 into a single unified DataFrame using wildcard loading
- Saved all transformed data as Delta Lake Parquet files in the silver container

### Gold Layer - Data Serving

- Connected Azure Synapse Analytics Serverless SQL Pool to the silver container
- Created a database scoped credential using Managed Identity for secure access
- Created external data sources pointing to silver and gold containers
- Created SQL views using OPENROWSET to reference silver Parquet files
- Created external tables in the gold container using CTAS (Create Table As Select)
- All external tables saved as Snappy-compressed Parquet files in the gold container

---

## Project Structure

```
AdventureWorks-Azure-Data-Engineering/
|
|-- README.md
|
|-- config/
|   |-- git.json                        # Dynamic pipeline file configuration
|
|-- pipelines/
|   |-- GitToRaw.json                   # Static ADF pipeline
|   |-- DynamicGitToRaw.json            # Dynamic ADF pipeline with Lookup and ForEach
|
|-- notebooks/
|   |-- silver_layer.ipynb              # Databricks PySpark transformation notebook
|
|-- sql_scripts/
|   |-- 01_setup.sql                    # Master key, credentials, data sources, file formats
|   |-- 02_views.sql                    # Gold schema SQL views using OPENROWSET
|   |-- 03_external_tables.sql          # Gold layer external tables
```

---

## Key Concepts Demonstrated

- Medallion Architecture (Bronze, Silver, Gold)
- Dynamic pipeline design using JSON configuration files
- Parameterized datasets in Azure Data Factory
- PySpark data transformation at scale using Apache Spark
- Delta Lake storage format with Snappy compression
- Serverless SQL Pool with external tables and views
- Managed Identity authentication for secure storage access
- OPENROWSET for querying Data Lake files directly using SQL
- Power BI integration with Azure Synapse Analytics

---

## Pipeline Design

The ADF pipeline uses a dynamic design pattern:

1. A JSON configuration file stored in Azure Data Lake lists all source files with their relative GitHub URL, destination folder name, and destination file name.
2. A Lookup Activity reads the JSON configuration file.
3. A ForEach Activity iterates over each item in the configuration list.
4. Inside the ForEach, a Copy Activity uses parameterized datasets to dynamically set the source URL and sink folder and file name using the @item() expression.

This design means adding a new source file only requires updating the JSON configuration file with no changes to the pipeline itself.

---

## How to Run This Project

### Prerequisites

- Active Azure subscription
- Azure Data Factory instance
- Azure Data Lake Gen2 storage account with bronze, silver, and gold containers
- Azure Databricks workspace
- Azure Synapse Analytics workspace

### Steps

1. Upload the git.json configuration file to the bronze container in your Data Lake.
2. Create the HTTP and ADLS Gen2 linked services in Azure Data Factory.
3. Import and run the DynamicGitToRaw pipeline to load raw CSV files into the bronze container.
4. Configure Databricks storage access using OAuth and run the silver_layer notebook to transform and save data to the silver container.
5. In Azure Synapse Analytics, run the SQL scripts in order: 01_setup, 02_views, 03_external_tables.
6. Connect Power BI Desktop to the Synapse Serverless SQL endpoint and build reports from the gold layer external tables.

---

## Results

The pipeline successfully:

- Ingested 10 CSV files dynamically from a public GitHub repository
- Transformed and cleaned all data using PySpark in Databricks
- Stored cleaned data as Delta Lake Parquet files in the silver layer
- Created queryable SQL views and external tables in the gold layer
- Made data available for Power BI reporting through Azure Synapse Analytics

---

## Author

Abhishek Reddy Manam


