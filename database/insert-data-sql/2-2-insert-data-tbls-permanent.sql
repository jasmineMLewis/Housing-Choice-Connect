USE HousingChoiceConnect;
GO

/****** 
Tables: 
- EliteTenantImport
- Users
******/


/****** Object:  Table dbo.EliteTenantImport  ******/
INSERT INTO EliteTenantImport (FirstName, LastName, EntityID, DisguisedTaxID) VALUES ('Adam', 'Corn', '197095642', 'XXX-XX-9708');
INSERT INTO EliteTenantImport (FirstName, LastName, EntityID, DisguisedTaxID) VALUES ('Lazaro', 'Bellido', '479669247', 'XXX-XX-6465');
INSERT INTO EliteTenantImport (FirstName, LastName, EntityID, DisguisedTaxID) VALUES ('Billy', 'Brake', '331449669', 'XXX-XX-7987');
INSERT INTO EliteTenantImport (FirstName, LastName, EntityID, DisguisedTaxID) VALUES ('Fili', 'Luna', '118325128', 'XXX-XX-1316');
INSERT INTO EliteTenantImport (FirstName, LastName, EntityID, DisguisedTaxID) VALUES ('Jeff', 'Jones', '781376310', 'XXX-XX-8976');


/****** Object:  Table dbo.Users  ******/
INSERT INTO Users (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, RoleID, Code) VALUES ('Patrick', 'Hoban', 'PatrickHoban@gmail.com', 'Qwerty1', '0', '0', GETDATE(), GETDATE(), '2', '2123');
INSERT INTO Users (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, RoleID, Code) VALUES ('Jason', 'Holloway', 'JasonHolloway@gmail.com', 'Qwerty1', '0', '0', GETDATE(), GETDATE(), '2', '4534');
INSERT INTO Users (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, RoleID, Code) VALUES ('Cesar ', 'Gonzalez ', 'CesarGonzalez@gmail.com', 'Qwerty1', '0', '0', GETDATE(), GETDATE(), '3', '8665');
INSERT INTO Users (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, RoleID, Code) VALUES ('Shannon', 'Long', 'ShannonLong@gmail.com', 'Qwerty1', '0', '0', GETDATE(), GETDATE(), '3', '7845');