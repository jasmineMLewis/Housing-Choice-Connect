USE HousingChoiceConnect;
GO

/****** 
Tables: 
- Security.UserRole


----- NEED TO EXPORT DATA FROM THE FOLLOWING Tables: 4
- Security.UserQuestion
- Landlord.PropertyAddress
- Landlord.PropertyAmentity
- Landlord.PropertyHandicapAccessibility
******/


/****** Object:  Table Security.UserRole  ******/
INSERT INTO Security.UserRole (UserID, RoleID) VALUES ('1', '1'); -- Jasmine Lewis | Admin
INSERT INTO Security.UserRole (UserID, RoleID) VALUES ('2', '2'); -- Patrick Hoban | Tenant
INSERT INTO Security.UserRole (UserID, RoleID) VALUES ('3', '2'); -- Jason Holloway | Tenant
INSERT INTO Security.UserRole (UserID, RoleID) VALUES ('4', '2'); -- Billy Brake | Tenant
INSERT INTO Security.UserRole (UserID, RoleID) VALUES ('5', '2'); -- Fili Luna | Tenant
INSERT INTO Security.UserRole (UserID, RoleID) VALUES ('6', '2'); -- Jeff Jones | Tenant
INSERT INTO Security.UserRole (UserID, RoleID) VALUES ('7', '3'); -- Cesar  Gonzalez | Landlord
INSERT INTO Security.UserRole (UserID, RoleID) VALUES ('8', '3'); -- Shannon Long | Landlord