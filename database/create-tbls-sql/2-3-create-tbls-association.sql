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
- Landlord.PropertyAmentity
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
 CONSTRAINT FK_LandlordPropertyAmentity_LandlordPropertyID_LandlordProperty_LandlordPropertyID FOREIGN KEY (LandlordPropertyID) REFERENCES [Landlord.Property](LandlordPropertyID) ON DELETE CASCADE,
 INDEX IX_LandlordPropertyAmentity_LandlordPropertyID NONCLUSTERED (LandlordPropertyID),
 CONSTRAINT FK_LandlordPropertyAmentity_AmentityID_Amentity_AmentityID FOREIGN KEY (AmentityID) REFERENCES [Amentity](AmentityID) ON DELETE CASCADE,
 INDEX IX_LandlordPropertyAmentity_AmentityID NONCLUSTERED (AmentityID)
)
GO


/****** Object:  Table Security.UserSecurityQuestion  ******/
DROP TABLE IF EXISTS Security.UserSecurityQuestion
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Security.UserSecurityQuestion(
	UserSecurityQuestionID int IDENTITY(1,1) NOT NULL,
	Response varchar(50) NOT NULL,
	SecurityQuestionID int NOT NULL,
	UserID int NOT NULL,
 CONSTRAINT PK_UserSecurityQuestion_UserSecurityQuestionID PRIMARY KEY CLUSTERED (UserSecurityQuestionID ASC),
 INDEX IX_UserSecurityQuestion_UserSecurityQuestionID NONCLUSTERED (UserSecurityQuestionID),
 CONSTRAINT FK_UserSecurityQuestion_UserID_User_UserID FOREIGN KEY (UserID) REFERENCES [Security.User](UserID) ON DELETE CASCADE,
 INDEX IX_UserSecurityQuestion_UserID NONCLUSTERED (UserID),
 CONSTRAINT FK_UserSecurityQuestion_SecurityQuestionID_SecurityQuestion_SecurityQuestionID FOREIGN KEY (SecurityQuestionID) REFERENCES [SecurityQuestion](SecurityQuestionID) ON DELETE CASCADE,
 INDEX IX_UserSecurityQuestion_SecurityQuestionID NONCLUSTERED (SecurityQuestionID)
)
GO