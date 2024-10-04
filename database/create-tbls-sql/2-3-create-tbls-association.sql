IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'HousingChoiceConnect')
BEGIN
  CREATE DATABASE HousingChoiceConnect;
END;
GO

USE HousingChoiceConnect;
GO

/****** 
Tables: 4
- Landlord.PropertyAddress
- Landlord.PropertyAmentity
- Security.UserRole
- Security.UserSecurityQuestion
******/

/****** Object:  Table Landlord.PropertyAddress ******/
DROP TABLE IF EXISTS Landlord.PropertyAddress
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Landlord.PropertyAddress (
	AddressID int IDENTITY(1,1) NOT NULL,
	Address varchar(50) NOT NULL,
	AptSuite varchar(7) NULL,
	City varchar(25) NOT NULL,
	State varchar(25) NOT NULL,
	NeighborhoodID int NOT NULL,
	LandlordPropertyID int NOT NULL,
 CONSTRAINT PK_AddressID PRIMARY KEY CLUSTERED (AddressID ASC),
 INDEX IX_AddressID NONCLUSTERED (AddressID),
 CONSTRAINT FK_PropertyAddress_Neighborhood_NeighborhoodID FOREIGN KEY (NeighborhoodID) REFERENCES Neighborhood(NeighborhoodID),
 INDEX IX_PropertyAddress_Neighborhood_NeighborhoodID NONCLUSTERED (NeighborhoodID),
 CONSTRAINT FK_PropertyAddress_LandlordProperty_LandlordPropertyID FOREIGN KEY (LandlordPropertyID) REFERENCES Landlord.Property(LandlordPropertyID),
 INDEX IX_PropertyAddress_LandlordProperty_LandlordPropertyID NONCLUSTERED (LandlordPropertyID)
)
GO

/****** Object:  Table Landlord.PropertyAmentity ******/
DROP TABLE IF EXISTS Landlord.PropertyAmentity
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Landlord.PropertyAmentity(
	LandlordPropertyID int NOT NULL,
	AmentityID int NOT NULL,
 CONSTRAINT PK_LandlordPropertyAmentity PRIMARY KEY CLUSTERED (LandlordPropertyID ASC, AmentityID ASC),
 CONSTRAINT FK_LandlordPropertyAmentity_LandlordProperty_LandlordPropertyID FOREIGN KEY (LandlordPropertyID) REFERENCES Landlord.Property(LandlordPropertyID),
 INDEX IX_LandlordPropertyAmentity_LandlordPropertyID NONCLUSTERED (LandlordPropertyID),
 CONSTRAINT FK_Amentity_AmentityID FOREIGN KEY (AmentityID) REFERENCES Amentity(AmentityID),
 INDEX IX_LandlordPropertyAmentity_AmentityID NONCLUSTERED (AmentityID)
)
GO


/****** Object:  Table Security.UserActivityLog ******/
DROP TABLE IF EXISTS Security.UserActivityLog
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Security.UserActivityLog (
	UserActivityLogID int IDENTITY(1,1) NOT NULL,
	UserID int NOT NULL,
	ActivityTypeID int NOT NULL,
	ActivityDate datetime NOT NULL,
	Descritption varchar(250) NOT NULL,
 CONSTRAINT PK_UserActivityLogID PRIMARY KEY CLUSTERED (UserActivityLogID ASC),
 INDEX IX_UserActivityLogID NONCLUSTERED (UserActivityLogID),
 CONSTRAINT FK_UserActivityLog_User_UserID FOREIGN KEY (UserID) REFERENCES Security.[User](UserID),
 INDEX IX_UserActivityLog_User_UserID NONCLUSTERED (UserID),
 CONSTRAINT FK_ActivityType_ActivityTypeID FOREIGN KEY (ActivityTypeID) REFERENCES ActivityType(ActivityTypeID),
 INDEX IX_UserActivityLog_ActivityType_ActivityTypeID NONCLUSTERED (ActivityTypeID)
)
GO


/****** Object:  Table Security.UserRole ******/
DROP TABLE IF EXISTS Security.UserRole
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Security.UserRole (
	UserRoleID int IDENTITY(1,1) NOT NULL,
	UserID int NOT NULL,
	RoleID int NOT NULL,
 CONSTRAINT PK_UserRoleID PRIMARY KEY CLUSTERED (UserRoleID ASC),
 INDEX IX_UserRoleID NONCLUSTERED (UserRoleID),
 CONSTRAINT FK_UserRole_User_UserID FOREIGN KEY (UserID) REFERENCES Security.[User](UserID),
 INDEX IX_User_UserID NONCLUSTERED (UserID),
 CONSTRAINT FK_Role_RoleID FOREIGN KEY (RoleID) REFERENCES [Role](RoleID),
 CONSTRAINT UserRole_UserID_RoleID UNIQUE (UserID, RoleID)
)
GO

/****** Object:  Table Security.UserQuestion  ******/
DROP TABLE IF EXISTS Security.UserQuestion
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Security.UserQuestion (
	UserQuestionID int IDENTITY(1,1) NOT NULL,
	Response varchar(50) NOT NULL,
	SecurityQuestionID int NOT NULL,
	UserID int NOT NULL,
 CONSTRAINT PK_UserQuestionID PRIMARY KEY CLUSTERED (UserQuestionID ASC),
 INDEX IX_UserQuestionID NONCLUSTERED (UserQuestionID),
 CONSTRAINT FK_SecurityQuestion_SecurityQuestionID FOREIGN KEY (SecurityQuestionID) REFERENCES SecurityQuestion(SecurityQuestionID),
 INDEX IX_SecurityQuestionID NONCLUSTERED (SecurityQuestionID),
 CONSTRAINT FK_UserQuestion_User_UserID FOREIGN KEY (UserID) REFERENCES Security.[User](UserID),
 INDEX IX_UserID NONCLUSTERED (UserID)
)
GO

