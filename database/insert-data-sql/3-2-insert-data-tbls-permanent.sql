USE HousingChoiceConnect;
GO

/****** 
Tables: 2
- Security.EliteTenantImport
- Security.User


----- NEED TO EXPORT DATA FROM THE FOLLOWING Tables: 1
- Landlord.Property
******/


/****** Object:  Table Security.EliteTenantImport  ******/
INSERT INTO Security.EliteTenantImport (FirstName, LastName, EntityID, DisguisedTaxID, DateOfBirth) VALUES ('Patrick', 'Hoban', '197095642', 'XXX-XX-9708', '2020-12-01');
INSERT INTO Security.EliteTenantImport (FirstName, LastName, EntityID, DisguisedTaxID, DateOfBirth) VALUES ('Jason', 'Holloway', '479669247', 'XXX-XX-6465', '1976-10-11');
INSERT INTO Security.EliteTenantImport (FirstName, LastName, EntityID, DisguisedTaxID, DateOfBirth) VALUES ('Billy', 'Brake', '331449669', 'XXX-XX-7987', '1948-11-30');
INSERT INTO Security.EliteTenantImport (FirstName, LastName, EntityID, DisguisedTaxID, DateOfBirth) VALUES ('Fili', 'Luna', '118325128', 'XXX-XX-1316', '1999-9-27');
INSERT INTO Security.EliteTenantImport (FirstName, LastName, EntityID, DisguisedTaxID, DateOfBirth) VALUES ('Jeff', 'Jones', '781376310', 'XXX-XX-8976', '1989-07-13');


/****** Object:  Table Security.User  ******/
INSERT INTO Security.[User] (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, IsActive) VALUES ('Jasmine', 'Lewis', 'jasmine.lewis@artistikrebellion.us', 'Qwerty1', '0', '0', GETDATE(), GETDATE(), '1'); --Admin
INSERT INTO Security.[User] (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, IsActive) VALUES ('Patrick', 'Hoban', 'PatrickHoban@gmail.com', 'Qwerty1', '0', '0', GETDATE(), GETDATE(), '1'); --Tenant
INSERT INTO Security.[User] (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, IsActive) VALUES ('Jason', 'Holloway', 'JasonHolloway@gmail.com', 'Qwerty1', '0', '0', GETDATE(), GETDATE(), '1'); --Tenant
INSERT INTO Security.[User] (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, IsActive) VALUES ('Billy', 'Brake', 'BillyBrake@gmail.com', 'Qwerty1', '0', '0', GETDATE(), GETDATE(), '1'); --Tenant
INSERT INTO Security.[User] (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, IsActive) VALUES ('Fili', 'Luna', 'FiliLuna@gmail.com', 'Qwerty1', '0', '0', GETDATE(), GETDATE(), '1'); --Tenant
INSERT INTO Security.[User] (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, IsActive) VALUES ('Jeff', 'Jones', 'JeffJones@gmail.com', 'Qwerty1', '0', '0', GETDATE(), GETDATE(), '1'); --Tenant
INSERT INTO Security.[User] (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, IsActive) VALUES ('Cesar ', 'Gonzalez', 'CesarGonzalez@gmail.com', 'Qwerty1', '0', '0', GETDATE(), GETDATE(), '1'); --Landlord
INSERT INTO Security.[User] (FirstName, LastName, Email, Password, IsEmailVerified, IsSecurityQuestionsCompleted, DateRegistered, LastLogin, IsActive) VALUES ('Shannon', 'Long', 'ShannonLong@gmail.com', 'Qwerty1', '0', '0', GETDATE(), GETDATE(), '1'); --Landlord