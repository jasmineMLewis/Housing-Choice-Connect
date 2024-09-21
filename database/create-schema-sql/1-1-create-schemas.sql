IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'HousingChoiceConnect')
BEGIN
  CREATE DATABASE HousingChoiceConnect;
END;
GO

USE HousingChoiceConnect;
GO


/****** 
Schema: 1
Schemas:
- LandlordProperty
******/


CREATE SCHEMA LandlordProperty AUTHORIZATION dbo;
GO