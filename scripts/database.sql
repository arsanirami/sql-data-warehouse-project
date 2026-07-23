/*
    Script Purpose:
    This script initializes the Datawarehouse database environment by:
    1. Checking whether the 'Datawarehouse' database already exists.
    2. Dropping the existing database and terminating any active connections.
    3. Creating a new 'Datawarehouse' database.
    4. Creating the Bronze, Silver, and Gold schemas.

    WARNING:
    - This script permanently deletes the existing 'Datawarehouse' database.
    - All data, tables, views, stored procedures, functions, and permissions
      contained within the database will be lost.
    - Ensure that a backup has been taken before executing this script in
      a production or shared environment.
    - Execute this script only if you intend to recreate the database from
      scratch.
*/

USE master;
GO

/* check if the Datawarehouse database exists and if it exists drop it */

IF EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'Datawarehouse'
)
BEGIN
    ALTER DATABASE Datawarehouse
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    DROP DATABASE Datawarehouse;
END;
GO

CREATE DATABASE Datawarehouse;
USE Datawarehouse;

-- create schemas

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
