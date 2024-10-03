IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'HousingChoiceConnect')
BEGIN
  CREATE DATABASE HousingChoiceConnect;
END;
GO

USE HousingChoiceConnect;
GO

/****** 
Tables: 
Tables:
- Landlord.PropertyAmentity
- Security.UserRole
- Security.UserSecurityQuestion
******/

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
 CONSTRAINT FK_LandlordProperty_LandlordPropertyID FOREIGN KEY (LandlordPropertyID) REFERENCES Landlord.Property(LandlordPropertyID),
 INDEX IX_LandlordPropertyAmentity_LandlordPropertyID NONCLUSTERED (LandlordPropertyID),
 CONSTRAINT FK_Amentity_AmentityID FOREIGN KEY (AmentityID) REFERENCES Amentity(AmentityID),
 INDEX IX_LandlordPropertyAmentity_AmentityID NONCLUSTERED (AmentityID)
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

