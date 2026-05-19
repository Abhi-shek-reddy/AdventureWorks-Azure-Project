CREATE VIEW gold.calendar
AS
SELECT * FROM OPENROWSET(
    BULK 'abfss://silver@awstroagedatalakeabhi.dfs.core.windows.net/AdventureWorks_Calendar/',
    FORMAT = 'PARQUET'
) AS query1

-- Customers
CREATE VIEW gold.customers
AS
SELECT * FROM OPENROWSET(
    BULK 'abfss://silver@awstroagedatalakeabhi.dfs.core.windows.net/AdventureWorks_Customer/',
    FORMAT = 'PARQUET'
) AS query1

-- Products
CREATE VIEW gold.products
AS
SELECT * FROM OPENROWSET(
    BULK 'abfss://silver@awstroagedatalakeabhi.dfs.core.windows.net/AdventureWorks_Product/',
    FORMAT = 'PARQUET'
) AS query1

-- Sales
CREATE VIEW gold.sales
AS
SELECT * FROM OPENROWSET(
    BULK 'abfss://silver@awstroagedatalakeabhi.dfs.core.windows.net/AdventureWorks_Sales/',
    FORMAT = 'PARQUET'
) AS query1

-- Returns
CREATE VIEW gold.returns
AS
SELECT * FROM OPENROWSET(
    BULK 'abfss://silver@awstroagedatalakeabhi.dfs.core.windows.net/AdventureWorks_Return/',
    FORMAT = 'PARQUET'
) AS query1

-- Territories
CREATE VIEW gold.territories
AS
SELECT * FROM OPENROWSET(
    BULK 'abfss://silver@awstroagedatalakeabhi.dfs.core.windows.net/AdventureWorks_Territory/',
    FORMAT = 'PARQUET'
) AS query1
