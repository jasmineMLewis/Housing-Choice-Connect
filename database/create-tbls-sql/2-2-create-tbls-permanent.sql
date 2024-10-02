IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'HousingChoiceConnect')
BEGIN
  CREATE DATABASE HousingChoiceConnect;
END;
GO

USE HousingChoiceConnect;
GO

/****** 
Tables: 6
Tables:
- Security.EliteTenantImport
- Security.User
- Landlord.Property
- Landlord.PropertyHandicapAccessibility
- Landlord.PropertyPicture
******/


/****** Object: Table Security.EliteTenantImport ******/
DROP TABLE IF EXISTS Security..EliteTenantImport
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Security.EliteTenantImport(
	EliteTenantImportID int IDENTITY(1,1) NOT NULL,
	FirstName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	EntityID varchar(50) NOT NULL,
	DisguisedTaxID varchar(50) NOT NULL,
 CONSTRAINT PK_EliteTenantImport_EliteTenantImportID PRIMARY KEY CLUSTERED (EliteTenantImportID),
 INDEX IX_EliteTenantImport_EliteTenantImportID NONCLUSTERED (EliteTenantImportID),
 INDEX IX_EliteTenantImport_EntityID NONCLUSTERED (EntityID)
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
 INDEX IX_User_Email NONCLUSTERED (Email)
)
GO


/****** Object:  Table Landlord.Property ******/
DROP TABLE IF EXISTS Landlord.Property
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*****/
CREATE TABLE Landlord.Property(
	LandlordPropertyID int IDENTITY(1,1) NOT NULL,
	AddressProperty varchar(100) NOT NULL,
	AptSuite varchar(100) NULL,
	City varchar(100) NULL,
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
	DateAvaiableToRent date NOT NULL,
	DateLastUpdated date NULL,
	DateOfInactivation date NULL,
	DateOfPostage date NOT NULL,
	UserID int NOT NULL,
	NeighborhoodID int NOT NULL,
	BedroomNumber int NULL,
	BathroomNumber int NULL,
	PropertyID int NOT NULL,
	UnitID int NOT NULL,
 CONSTRAINT PK_LandlordProperty_LandlordPropertyID PRIMARY KEY CLUSTERED (LandlordPropertyID ASC),
 INDEX IX_LandlordProperty_LandlordPropertyID NONCLUSTERED (LandlordPropertyID),
 CONSTRAINT FK_LandlordProperty_UserID_User_UserID FOREIGN KEY (UserID) REFERENCES [Security.User](UserID) ON DELETE CASCADE,
 INDEX IX_LandlordProperty_UserID NONCLUSTERED (UserID),
 CONSTRAINT FK_LandlordProperty_NeighborhoodID_Neighborhood_NeighborhoodID FOREIGN KEY (NeighborhoodID) REFERENCES [Neighborhood](NeighborhoodID) ON DELETE CASCADE,
 INDEX IX_LandlordProperty_NeighborhoodID NONCLUSTERED (NeighborhoodID),
 CONSTRAINT FK_LandlordProperty_PropertyID_Property_PropertyID FOREIGN KEY (PropertyID) REFERENCES [Property](PropertyID) ON DELETE CASCADE,
 INDEX IX_LandlordProperty_PropertyID NONCLUSTERED (PropertyID),
 CONSTRAINT FK_LandlordProperty_UnitID_Unit_UnitID FOREIGN KEY (UnitID) REFERENCES [Unit](UnitID) ON DELETE CASCADE,
 INDEX IX_LandlordProperty_UnitID NONCLUSTERED (UnitID)
)
GO


/****** Object:  Table Landlord.PropertyHandicapAccessibility ******/
DROP TABLE IF EXISTS Landlord.PropertyHandicapAccessibility
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Landlord.PropertyHandicapAccessibility(
	LandlordPropertyHandicapAccessibilityID int IDENTITY(1,1) NOT NULL,
	IsAccessibleParkingCloseToHome bit NULL DEFAULT 0,
	IsRampedEntry bit NULL DEFAULT 0,
	IsDoorways32Inches_Wider bit NULL DEFAULT 0,
	IsAccessiblePathToAndInHome32Inches_Wider bit NULL DEFAULT 0,
	IsAutomaticEntryDoor bit NULL DEFAULT 0,
	IsLowCounterSinkAtBelow34Inches bit NULL DEFAULT 0,
	IsAccessibleAppliances bit NULL DEFAULT 0,
	IsShowerTubGrabBars bit NULL DEFAULT 0,
	IsRollInShower bit NULL DEFAULT 0,
	IsHandHeldShowerSprayer bit NULL DEFAULT 0,
	IsFixedSeatInShowerTub bit NULL DEFAULT 0,
	IsRaisedToilet bit NULL DEFAULT 0,
	IsFirstFloorBedroom bit NULL DEFAULT 0,
	IsFirstFloorBathroom bit NULL DEFAULT 0,
	IsLiftElevator bit NULL DEFAULT 0,
	IsAudioVisualDoorbell bit NULL DEFAULT 0,
	IsAudioVisualSmokeFireAlarm bit NULL DEFAULT 0,
	IsElevatorAccess bit NULL DEFAULT 0,
	LandlordPropertyID int NULL,
 CONSTRAINT PK_LandlordPropertyHandicapAccessibility_LandlordPropertyHandicapAccessibilityID PRIMARY KEY CLUSTERED (LandlordPropertyHandicapAccessibilityID ASC),
 INDEX IX_LandlordPropertyHandicapAccessibility_LandlordPropertyHandicapAccessibilityID NONCLUSTERED (LandlordPropertyHandicapAccessibilityID),
 CONSTRAINT FK_LandlordPropertyHandicapAccessibility_LandlordPropertyID_LandlordProperty_LandlordPropertyID FOREIGN KEY (LandlordPropertyID) REFERENCES [Landlord.Property](LandlordPropertyID) ON DELETE CASCADE,
 INDEX IX_LandlordPropertyHandicapAccessibility_LandlordPropertyID NONCLUSTERED (LandlordPropertyID)
)
GO

/****** Object:  Table Landlord.PropertyPicture ******/
DROP TABLE IF EXISTS Landlord.PropertyPicture
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Landlord.PropertyPicture(
	LandlordPropertyPictureID int IDENTITY(1,1) NOT NULL,
	MIMEType varchar(max) NULL,
	ImageData varchar(max) NULL,
	LandlordPropertyID int NOT NULL,
 CONSTRAINT PK_LandlordPropertyPicture_LandlordPropertyPictureID PRIMARY KEY CLUSTERED (LandlordPropertyPictureID ASC),
 INDEX IX_LandlordPropertyPicture_LandlordPropertyPictureID NONCLUSTERED (LandlordPropertyPictureID),
 CONSTRAINT FK_LandlordPropertyPicture_LandlordPropertyID_LandlordProperty_LandlordPropertyID FOREIGN KEY (LandlordPropertyID) REFERENCES [Landlord.Property](LandlordPropertyID) ON DELETE CASCADE,
 INDEX IX_LandlordPropertyPicture_LandlordPropertyID NONCLUSTERED (LandlordPropertyID)
)
GO