USE HousingChoiceConnect;
GO

/****** 
Tables: 2
- EliteTenantImport
- User
******/


/****** Object:  Table dbo.EliteTenantImport  ******/
INSERT INTO EliteTenantImport (FirstName, LastName, EntityID, DisguisedTaxID) VALUES ('Patrick', 'Hoban', '197095642', 'XXX-XX-9708');
INSERT INTO EliteTenantImport (FirstName, LastName, EntityID, DisguisedTaxID) VALUES ('Jason', 'Holloway', '479669247', 'XXX-XX-6465');
INSERT INTO EliteTenantImport (FirstName, LastName, EntityID, DisguisedTaxID) VALUES ('Billy', 'Brake', '331449669', 'XXX-XX-7987');
INSERT INTO EliteTenantImport (FirstName, LastName, EntityID, DisguisedTaxID) VALUES ('Fili', 'Luna', '118325128', 'XXX-XX-1316');
INSERT INTO EliteTenantImport (FirstName, LastName, EntityID, DisguisedTaxID) VALUES ('Jeff', 'Jones', '781376310', 'XXX-XX-8976');


/****** Object:  Table dbo.User  ******/
INSERT INTO [User] (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, RoleID) VALUES ('Jasmine', 'Lewis', 'jasmine.lewis@artistikrebellion.us', 'Qwerty1', '0', '0', GETDATE(), GETDATE(), '1');
INSERT INTO [User] (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, RoleID) VALUES ('Patrick', 'Hoban', 'PatrickHoban@gmail.com', 'Qwerty1', '0', '0', GETDATE(), GETDATE(), '2');
INSERT INTO [User] (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, RoleID) VALUES ('Jason', 'Holloway', 'JasonHolloway@gmail.com', 'Qwerty1', '0', '0', GETDATE(), GETDATE(), '2');
INSERT INTO [User] (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, RoleID) VALUES ('Cesar ', 'Gonzalez ', 'CesarGonzalez@gmail.com', 'Qwerty1', '0', '0', GETDATE(), GETDATE(), '3');
INSERT INTO [User] (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, RoleID) VALUES ('Shannon', 'Long', 'ShannonLong@gmail.com', 'Qwerty1', '0', '0', GETDATE(), GETDATE(), '3');