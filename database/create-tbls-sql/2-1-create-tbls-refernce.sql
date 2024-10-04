IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'HousingChoiceConnect')
BEGIN
  CREATE DATABASE HousingChoiceConnect;
END;
GO

USE HousingChoiceConnect;
GO

/****** 
Tables: 8
- ActivityType
- Location
- Amentity
- Zip Code
- Neighborhood
- Property
- Role
- SecurityQuestion
- Unit
******/

/****** Object:  Table dbo.ActivityType  ******/
DROP TABLE  IF EXISTS dbo.ActivityType
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.ActivityType (
	ActivityTypeID int IDENTITY(1,1) NOT NULL,
	Activity varchar(50) NOT NULL,
 CONSTRAINT PK_ActivityTypeID PRIMARY KEY CLUSTERED (ActivityTypeID ASC),
 INDEX IX_ActivityTypeID NONCLUSTERED (ActivityTypeID),
 CONSTRAINT ActivityType_Activity UNIQUE (Activity),
)
GO

/****** Object:  Table dbo.Location  ******/
DROP TABLE  IF EXISTS dbo.Location
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.Location (
	LocationID int IDENTITY(1,1) NOT NULL,
	Location varchar(50) NOT NULL,
 CONSTRAINT PK_LocationID PRIMARY KEY CLUSTERED (LocationID ASC),
 INDEX IX_LocationID NONCLUSTERED (LocationID),
 CONSTRAINT Location_Location UNIQUE (Location),
)
GO

/****** Object:  Table dbo.Amentity  ******/
DROP TABLE  IF EXISTS dbo.Amentity
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.Amentity (
	AmentityID int IDENTITY(1,1) NOT NULL,
	Amentity varchar(50) NOT NULL,
	LocationID int NOT NULL,
 CONSTRAINT PK_AmentityID PRIMARY KEY CLUSTERED (AmentityID ASC),
 INDEX IX_AmentityID NONCLUSTERED (AmentityID),
 CONSTRAINT FK_Location_LocationID FOREIGN KEY (LocationID) REFERENCES Location(LocationID),
 CONSTRAINT Amentity_Amentity UNIQUE (Amentity),
)
GO

/****** Object:  Table dbo.ZipCode  ******/
DROP TABLE  IF EXISTS dbo.ZipCode
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.ZipCode(
	ZipCodeID int IDENTITY(1,1) NOT NULL,
	ZipCode int NOT NULL,
 CONSTRAINT PK_ZipCodeID PRIMARY KEY CLUSTERED (ZipCodeID ASC),
 INDEX IX_ZipCodeID NONCLUSTERED (ZipCodeID),
 INDEX IX_ZipCode NONCLUSTERED (ZipCode),
 CONSTRAINT ZipCode_ZipCode UNIQUE (ZipCode)
 )
GO

/****** Object:  Table dbo.Neighborhood  ******/
DROP TABLE  IF EXISTS dbo.Neighborhood
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.Neighborhood(
	NeighborhoodID int IDENTITY(1,1) NOT NULL,
	Neighborhood varchar(50) NOT NULL,
	ZipCodeID int NOT NULL,
 CONSTRAINT PK_NeighborhoodID PRIMARY KEY CLUSTERED (NeighborhoodID ASC),
 INDEX IX_NeighborhoodID NONCLUSTERED (NeighborhoodID),
 INDEX IX_Neighborhood NONCLUSTERED (Neighborhood),
 CONSTRAINT FK_ZipCode_ZipCodeID FOREIGN KEY (ZipCodeID) REFERENCES [ZipCode](ZipCodeID),
 INDEX IX_ZipCodeID NONCLUSTERED (ZipCodeID)
 )
GO

/****** Object:  Table dbo.Property ******/
DROP TABLE  IF EXISTS dbo.Property
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.Property(
	PropertyID int IDENTITY(1,1) NOT NULL,
	Property varchar(50) NOT NULL,
 CONSTRAINT PK_PropertyID PRIMARY KEY CLUSTERED (PropertyID ASC),
 INDEX IX_PropertyID NONCLUSTERED (PropertyID)
)
GO

/****** Object:  Table dbo.Role ******/
DROP TABLE IF EXISTS dbo.Role
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.Role(
	RoleID int IDENTITY(1,1) NOT NULL,
	RoleName varchar(50) NOT NULL,
	Description varchar(250) NOT NULL,
 CONSTRAINT PK_RoleID PRIMARY KEY CLUSTERED (RoleID ASC),
 INDEX IX_RoleID NONCLUSTERED (RoleID),
 CONSTRAINT Role_RoleName UNIQUE (RoleName)
)
GO

/****** Object:  Table dbo.SecurityQuestion ******/
DROP TABLE IF EXISTS dbo.SecurityQuestion
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.SecurityQuestion (
	SecurityQuestionID int IDENTITY(1,1) NOT NULL,
	Question varchar(225) NOT NULL,
 CONSTRAINT PK_SecurityQuestionID PRIMARY KEY CLUSTERED (SecurityQuestionID ASC),
 INDEX IX_SecurityQuestionID NONCLUSTERED (SecurityQuestionID),
 CONSTRAINT SecurityQuestion_Question UNIQUE (Question)
)
GO


/****** Object:  Table dbo.Unit  ******/
DROP TABLE IF EXISTS dbo.Unit
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE TABLE dbo.Unit(
	UnitID int IDENTITY(1,1) NOT NULL,
	Unit varchar(50) NOT NULL,
 CONSTRAINT PK_UnitID PRIMARY KEY CLUSTERED (UnitID ASC),
 INDEX IX_UnitID NONCLUSTERED (UnitID),
 CONSTRAINT Unit_Unit UNIQUE (Unit)
)
GO