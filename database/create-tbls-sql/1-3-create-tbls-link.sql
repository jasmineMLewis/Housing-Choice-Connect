IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'HousingChoiceConnect')
BEGIN
  CREATE DATABASE HousingChoiceConnect;
END;
GO

USE HousingChoiceConnect;
GO

/****** 
Tables: 1
Tables:
- LandlordPropertyAmentity
******/

/****** Object:  Table dbo.LandlordPropertyAmentity ******/
DROP TABLE IF EXISTS dbo.LandlordPropertyAmentity
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.LandlordPropertyAmentity(
	LandlordPropertyID int NOT NULL,
	AmentityID int NOT NULL,
 CONSTRAINT PK_LandlordPropertyAmentity PRIMARY KEY CLUSTERED (LandlordPropertyID ASC, AmentityID ASC),
 CONSTRAINT FK_LandlordPropertyAmentity_LandlordPropertyID_LandlordProperty_LandlordPropertyID FOREIGN KEY (LandlordPropertyID) REFERENCES [LandlordProperty](LandlordPropertyID) ON DELETE CASCADE,
 INDEX IX_LandlordPropertyAmentity_LandlordPropertyID NONCLUSTERED (LandlordPropertyID),
 CONSTRAINT FK_LandlordPropertyAmentity_AmentityID_Amentity_AmentityID FOREIGN KEY (AmentityID) REFERENCES [Amentity](AmentityID) ON DELETE CASCADE,
 INDEX IX_LandlordPropertyAmentity_AmentityID NONCLUSTERED (AmentityID)
)
GO