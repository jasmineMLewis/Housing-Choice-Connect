IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'HousingChoiceConnect')
BEGIN
  CREATE DATABASE HousingChoiceConnect;
END;
GO

USE HousingChoiceConnect;
GO

/****** 
Tables: 6
- Amentity
- Neighborhood
- Property
- UserRole
- SecurityQuestion
- Unit
******/

/****** Object:  Table dbo.Amentity  ******/
DROP TABLE  IF EXISTS dbo.Amentity
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.Amentity(
	AmentityID int IDENTITY(1,1) NOT NULL,
	Amentity varchar(50) NOT NULL,
	Location varchar(50) NULL,
 CONSTRAINT PK_Amentity_AmentityID PRIMARY KEY CLUSTERED (AmentityID ASC),
 INDEX IX_Amentity_AmentityID NONCLUSTERED (AmentityID)
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
	ZipCode int NOT NULL,
 CONSTRAINT PK_Neighborhood_NeighborhoodID PRIMARY KEY CLUSTERED (NeighborhoodID ASC),
 INDEX IX_Neighborhood_NeighborhoodID NONCLUSTERED (NeighborhoodID),
 INDEX IX_Neighborhood_Neighborhood NONCLUSTERED (Neighborhood),
 INDEX IX_Neighborhood_ZipCode NONCLUSTERED (ZipCode)
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
 CONSTRAINT PK_Property_PropertyID PRIMARY KEY CLUSTERED (PropertyID ASC),
 INDEX IX_Property_PropertyID NONCLUSTERED (PropertyID)
)
GO

/****** Object:  Table dbo.Role ******/
DROP TABLE IF EXISTS dbo.Role
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.UserRole(
	UserRoleID int IDENTITY(1,1) NOT NULL,
	RoleName varchar(50) NOT NULL,
	Description varchar(250) NOT NULL,
 CONSTRAINT PK_Role_UserRoleID PRIMARY KEY CLUSTERED (UserRoleID ASC),
 INDEX IX_Role_UserRoleID NONCLUSTERED (UserRoleID)
)
GO

/****** Object:  Table dbo.SecurityQuestion ******/
DROP TABLE IF EXISTS dbo.SecurityQuestion
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.SecurityQuestion(
	SecurityQuestionID int IDENTITY(1,1) NOT NULL,
	Question varchar(225) NOT NULL,
 CONSTRAINT PK_SecurityQuestion_SecurityQuestionID PRIMARY KEY CLUSTERED (SecurityQuestionID ASC),
 INDEX IX_SecurityQuestion_SecurityQuestionID NONCLUSTERED (SecurityQuestionID)
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
 CONSTRAINT PK_Unit_UnitID PRIMARY KEY CLUSTERED (UnitID ASC),
 INDEX IX_Unit_UnitID NONCLUSTERED (UnitID)
)
GO