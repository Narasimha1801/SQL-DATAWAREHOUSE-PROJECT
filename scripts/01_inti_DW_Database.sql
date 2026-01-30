/*===============================================================
  DATA WAREHOUSE INITIAL SETUP
  CREATES DATA WAREHOUSE DATABASE AND LAYERED SCHEMAS
================================================================*/

-- Switch to master to safely create a new database
USE master;
GO

-- Create the main data warehouse database
CREATE DATABASE DataWarehouse_p1;
GO

-- Switch context to the new database
USE DataWarehouse_p1;
GO

/*===============================================================
  CREATE DATA WAREHOUSE LAYERS
  BRONZE  = RAW DATA (STAGING)
  SILVER  = CLEANED & TRANSFORMED DATA
  GOLD    = ANALYTICS-READY DATA
================================================================*/

-- Schema for raw ingested data
CREATE SCHEMA bronze;
GO

-- Schema for cleaned and transformed data
CREATE SCHEMA silver;
GO

-- Schema for business-level aggregated data
CREATE SCHEMA gold;
GO
