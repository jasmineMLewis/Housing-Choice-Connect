IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'HousingChoiceConnect')
BEGIN
  CREATE DATABASE HousingChoiceConnect;
END;
GO

USE HousingChoiceConnect;
GO

/****** 
Tables: 3
- Security.EliteTenantImport
- Security.User
- Landlord.Property
******/


/****** Object: Table Security.EliteTenantImport ******/
DROP TABLE IF EXISTS Security.EliteTenantImport
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Security.EliteTenantImport (
	EliteTenantImportID int IDENTITY(1,1) NOT NULL,
	FirstName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	EntityID varchar(50) NOT NULL,
	DisguisedTaxID varchar(50) NOT NULL,
	DateOfBirth date NOT NULL,
 CONSTRAINT PK_EliteTenantImportID PRIMARY KEY CLUSTERED (EliteTenantImportID),
 INDEX IX_EliteTenantImportID NONCLUSTERED (EliteTenantImportID),
 INDEX IX_EntityID NONCLUSTERED (EntityID),
 CONSTRAINT EliteTenantImport_EntityID UNIQUE (EntityID)
)
GO


/****** Object:  Table Security.User  ******/
DROP TABLE IF EXISTS Security.[User]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Security.[User](
	UserID int IDENTITY(1,1) NOT NULL,
	FirstName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	Email varchar(50) NOT NULL UNIQUE,
	Password varchar(50) NOT NULL,
	IsEmailVerified bit NULL DEFAULT 0,
	IsSecurityQuestionsCompleted bit NULL DEFAULT 0,
	DateRegistered datetime NOT NULL,
	LastLogin datetime NULL,
	IsActive bit NULL DEFAULT 1,
 CONSTRAINT PK_User_UserID PRIMARY KEY CLUSTERED (UserID ASC),
 INDEX IX_User_UserID NONCLUSTERED (UserID),
 INDEX IX_User_Email NONCLUSTERED (Email),
 CONSTRAINT User_Email UNIQUE (Email)
)
GO


/****** Object:  Table Landlord.Property ******/
DROP TABLE IF EXISTS Landlord.Property
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Landlord.Property(
	LandlordPropertyID int IDENTITY(1,1) NOT NULL,
	Description varchar(1000) NULL,
	Rent money NULL,
	Deposit money NULL,
	PetDeposit money NULL,
	PersonOfContact varchar(25) NULL,
	PersonToContactPhoneNumber varchar(10) NULL,
	NumberOfTenantViews int NULL,
	IsUtilityElectricPaidByLandlord bit NULL DEFAULT 0,
	IsUtilityWaterPaidByLandlord bit NULL DEFAULT 0,
	IsUtilityGasPaidByLandlord bit NULL DEFAULT 0,
	IsAmentitiesIncluded bit NULL DEFAULT 0,
	IsHandicapAccessible bit NULL DEFAULT 0,
	IsPropertyReadyForOccupancy bit NULL DEFAULT 0,
	IsPetsPermitted bit NULL DEFAULT 0,
	IsPicturesExists bit NULL,
	IsActive bit NULL DEFAULT 1,
	BedroomNumber int NULL,
	BathroomNumber int NULL,
	DateAvaiableToRent date NOT NULL,
	DateLastUpdated date NULL,
	DateOfInactivation date NULL,
	DateOfPostage date NOT NULL,
	UserID int NOT NULL,
	PropertyID int NOT NULL,
	UnitID int NOT NULL,
 CONSTRAINT PK_LandlordPropertyID PRIMARY KEY CLUSTERED (LandlordPropertyID ASC),
 INDEX IX_LandlordPropertyID NONCLUSTERED (LandlordPropertyID),
 CONSTRAINT FK_User_UserID FOREIGN KEY (UserID) REFERENCES Security.[User](UserID),
 INDEX IX_LandlordProperty_UserID NONCLUSTERED (UserID),
 CONSTRAINT FK_Property_PropertyID FOREIGN KEY (PropertyID) REFERENCES [Property](PropertyID),
 INDEX IX_LandlordProperty_PropertyID NONCLUSTERED (PropertyID),
 CONSTRAINT FK_Unit_UnitID FOREIGN KEY (UnitID) REFERENCES [Unit](UnitID),
 INDEX IX_LandlordProperty_UnitID NONCLUSTERED (UnitID)
)
GO