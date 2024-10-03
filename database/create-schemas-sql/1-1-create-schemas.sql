IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'HousingChoiceConnect')
BEGIN
  CREATE DATABASE HousingChoiceConnect;
END;
GO

USE HousingChoiceConnect;
GO

DROP SCHEMA IF EXISTS Security;

CREATE SCHEMA Security AUTHORIZATION dbo;
GO


DROP SCHEMA IF EXISTS Landlord;

CREATE SCHEMA Landlord AUTHORIZATION dbo;
GO