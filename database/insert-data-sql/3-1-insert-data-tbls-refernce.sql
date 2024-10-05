USE HousingChoiceConnect;
GO

/****** 
Tables: 8
- ActivityType
- Location 
- Amentity 
- Zip Code 
- Neighborhood 
- Property 
- Role 
- SecurityQuestion  
- Unit 
******/

-- Add the other Activity Types as you refactor code
/****** Object:  Table dbo.ActivityType  ******/
INSERT INTO ActivityType (Activity) VALUES ('Sign Up');
INSERT INTO ActivityType (Activity) VALUES ('Sign In');
--INSERT INTO ActivityType (Activity) VALUES ('');
--INSERT INTO ActivityType (Activity) VALUES ('');
--INSERT INTO ActivityType (Activity) VALUES ('');
--INSERT INTO ActivityType (Activity) VALUES ('');
--INSERT INTO ActivityType (Activity) VALUES ('');
--INSERT INTO ActivityType (Activity) VALUES ('');
--INSERT INTO ActivityType (Activity) VALUES ('');

/****** Object:  Table dbo.Location  ******/
INSERT INTO Location (Location) VALUES ('Indoor'); --1
INSERT INTO Location (Location) VALUES ('Outdoor'); --2
INSERT INTO Location (Location) VALUES ('Kitchen'); --3
INSERT INTO Location (Location) VALUES ('Other'); --4

/****** Object:  Table dbo.Amentity  ******/
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Central Air/Heat', '1'); --Indoor
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Washer', '1'); --Indoor
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Dryer', '1'); --Indoor
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Alarm', '1'); --Indoor
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Washer.Dryer Hookups', '1'); --Indoor
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Ceiling Fans', '1'); --Indoor
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Off Street Parking', '2'); --Outdoor
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Covered Parking', '2'); --Outdoor
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Front Yard', '2'); --Outdoor
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Back Yard', '2'); --Outdoor
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Gated', '2'); --Outdoor
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Dishwasher', '3'); --Kitchen
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Refrigerator', '3'); --Kitchen
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Garbage Disposal', '3'); --Kitchen
INSERT INTO Amentity (Amentity, LocationID) VALUES ('On Site Security', '4'); --Other


/****** Object:  Table dbo.ZipCode  ******/
INSERT INTO ZipCode (ZipCode) VALUES ('70112'); --1
INSERT INTO ZipCode (ZipCode) VALUES ('70113'); --2
INSERT INTO ZipCode (ZipCode) VALUES ('70114'); --3
INSERT INTO ZipCode (ZipCode) VALUES ('70115'); --4
INSERT INTO ZipCode (ZipCode) VALUES ('70116'); --5
INSERT INTO ZipCode (ZipCode) VALUES ('70117'); --6
INSERT INTO ZipCode (ZipCode) VALUES ('70118'); --7
INSERT INTO ZipCode (ZipCode) VALUES ('70119'); --8
INSERT INTO ZipCode (ZipCode) VALUES ('70124'); --9

INSERT INTO ZipCode (ZipCode) VALUES ('70122'); --17

INSERT INTO ZipCode (ZipCode) VALUES ('70125'); --10
INSERT INTO ZipCode (ZipCode) VALUES ('70126'); --11
INSERT INTO ZipCode (ZipCode) VALUES ('70127'); --12
INSERT INTO ZipCode (ZipCode) VALUES ('70128'); --13
INSERT INTO ZipCode (ZipCode) VALUES ('70129'); --14
INSERT INTO ZipCode (ZipCode) VALUES ('70130'); --15
INSERT INTO ZipCode (ZipCode) VALUES ('70131'); --16


/****** Object:  Table dbo.Neighborhood  ******/
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Algeirs Point', '3'); --70114
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Audubon', '4'); --70115
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Audubon', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Audubon', '10'); --70125
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('B. W. Cooper', '2'); --70113
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('B. W. Cooper', '10'); --70125
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Behrman', '3'); --70114
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Black Pearl', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Broadmoor', '10'); --70125
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Bywater', '6'); --70117
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Bywater', '11'); --70126
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Central Business District', '1'); --70112
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Central Business District', '2'); --70113
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Central Business District', '15'); --70130
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Central City', '2'); --70113
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Central City', '4'); --70115
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Central City', '10'); --70125
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Central City', '15'); --70130
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('City Park', '8'); --70119
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('City Park', '17'); --70122
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('City Park',  '9'); --70124
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Desire', '17'); --70122
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Desire', '10'); --70125
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Dillard', '17'); --70122
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Dixon', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('East Carollton', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Fillmore', '17'); --70122
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Fillmore',  '9'); --70124
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('French Quarter', '1'); --70112
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('French Quarter', '5'); --70116
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('French Quarter', '15'); --70130
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Freret', '4'); --70115
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Freret', '10'); --70125
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Garden District', '4'); --70115
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Garden District', '15'); --70130
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Gentilly Terrace', '17'); --70122
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Gentilly Woods', '11'); --70126
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Gert Town', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Gert Town', '10'); --70125
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Holly Grove', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Holy Cross', '6'); --70117
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Irish Channel', '4'); --70115
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Irish Channel', '15'); --70130
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Lake Catherine', '14'); --70129
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Lake Shore-Lake Vista', '9'); --70124
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Lake Terrace and Oaks', '17'); --70122
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Lake Terrace and Oaks', '9'); --70124
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Lake Terrace and Oaks', '11'); --70126
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Lakeview', '9'); --70124
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Lakewood', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Lakewood', '9'); --70124
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Leonidas', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Little Woods', '11'); --70126
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Little Woods', '12'); --70127
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Little Woods', '13'); --70128
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Little Woods', '14'); --70129
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Lower Garden District', '15'); --70130
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Lower Ninth Ward', '70032');
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Lower Ninth Ward', '6'); --70117
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Lower Ninth Ward', '11'); --70126
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Lower Ninth Ward', '14'); --70129
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Marlyville-Fontainebleau', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Marlyville-Fontainebleau', '10'); --70125
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Mid-City', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Mid-City', '8'); --70119
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Mid-City', '10'); --70125
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Milan', '4'); --70115
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Milan', '10'); --70125
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Milneburg', '17'); --70122
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Navarre', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Navarre', '8'); --70119
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Navarre', '9'); --70124
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Old Aurora', '3'); --70114
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Old Aurora', '16'); --70131
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Pines Village', '11'); --70126
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Plum Orchard', '11'); --70126
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Pontchartrain', '11'); --70126
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Read Blvd. East', '12'); --70127
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Read Blvd. West', '12'); --70127
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Read Blvd. West', '13'); --70128
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Seventh Ward', '70116');
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Seventh Ward', '4'); --70117
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Seventh Ward', '8'); --70119
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('St. Anthony', '17'); --70122
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('St. Bernard', '17'); --70122
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('St. Claude', '6'); --70117
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('St. Roch', '6'); --70117
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('St. Roch', '8'); --70119
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('St. Roch', '17'); --70122
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Tremé / Lafitte', '1'); --70112
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Tremé / Lafitte', '70116');
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Tremé / Lafitte', '8'); --70119
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Tulane - Gravier', '1'); --70112
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Tulane - Gravier', '2'); --70113
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Tulane - Gravier', '8'); --70119
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Tulane - Gravier', '10'); --70125
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Uptown', '4'); --70115
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Viavant-Venetian Isles', '6'); --70117
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Viavant-Venetian Isles', '11'); --70126
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Viavant-Venetian Isles', '12'); --70127
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Viavant-Venetian Isles', '14'); --70129
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Village De L''Est', '13'); --70128
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('Village De L''Est', '14'); --70129
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('West End', '9'); --70124
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('West Lake Forest', '11'); --70126
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('West Lake Forest', '12'); --70127
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('West Riverside', '4'); --70115
INSERT INTO Neighborhood (Neighborhood, ZipCodeID) VALUES ('West Riverside', '7'); --70118


/****** Object:  Table dbo.Property  ******/
INSERT INTO Property (Property) VALUES ('Single Family Home');
INSERT INTO Property (Property) VALUES ('Duplex/Double');
INSERT INTO Property (Property) VALUES ('Townhouse');
INSERT INTO Property (Property) VALUES ('Apt Complex/Garden Walkup');


/****** Object:  Table dbo.Role  ******/
INSERT INTO Role (RoleName, Description) VALUES ('Admin', 'An Admin can sign up, sign in, manage users and properties');
INSERT INTO Role (RoleName, Description) VALUES ('Tenant', 'A Tenant can sign up, sign in, edit profile and view landlord properties');
INSERT INTO Role (RoleName, Description) VALUES ('Landlord', 'A Landlord can sign up, sign in, edit profile, and manage properties');


/****** Object:  Table dbo.SecurityQuestion  ******/
INSERT INTO SecurityQuestion (Question) VALUES ('What is the last name of your favorite teacher?');
INSERT INTO SecurityQuestion (Question) VALUES ('What is one of your favorite holidays?');
INSERT INTO SecurityQuestion (Question) VALUES ('What city you were born in?');
INSERT INTO SecurityQuestion (Question) VALUES ('What is your favorite fruit?');
INSERT INTO SecurityQuestion (Question) VALUES ('What is your favorite color?');
INSERT INTO SecurityQuestion (Question) VALUES ('Who is your favorite musical artist?');


/****** Object:  Table dbo.Unit  ******/
INSERT INTO Unit (Unit) VALUES ('Ground Floor Unit');
INSERT INTO Unit (Unit) VALUES ('Upper Floor');
INSERT INTO Unit (Unit) VALUES ('Rear Apartment');