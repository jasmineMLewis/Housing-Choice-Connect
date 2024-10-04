USE HousingChoiceConnect;
GO

/****** 
Tables: 8
- ActivityType
- Location (Table Done, Need Insert)
- Amentity (Table Done, Need Insert)
- Zip Code (Table NOT Done)
- Neighborhood 
- Property
- Role
- SecurityQuestion
- Unit
******/

/****** Object:  Table dbo.Location  ******/
INSERT INTO Amentity (Location) VALUES ('Indoor'); --1
INSERT INTO Amentity (Location) VALUES ('Outdoor'); --2
INSERT INTO Amentity (Location) VALUES ('Kitchen'); --3
INSERT INTO Amentity (Location) VALUES ('Other'); --4

/****** Object:  Table dbo.Amentity  ******/
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Central Air/Heat', '1');
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Washer', '1');
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Dryer', '1');
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Alarm', '1');
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Washer.Dryer Hookups', '1');
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Ceiling Fans', '1');
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Dishwasher', '3');
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Refrigerator', '3');
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Garbage Disposal', '3');
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Off Street Parking', '2');
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Covered Parking', '2');
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Front Yard', '2');
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Back Yard', '2');
INSERT INTO Amentity (Amentity, LocationID) VALUES ('Gated', '2');
INSERT INTO Amentity (Amentity, LocationID) VALUES ('On Site Security', '4');


/****** Object:  Table dbo.ZipCode  ******/
INSERT INTO ZipCode (ZipCode) VALUES ('70112'); --1
INSERT INTO ZipCode (ZipCode) VALUES ('70113'); --2
INSERT INTO ZipCode (ZipCode) VALUES ('70114'); --3
INSERT INTO ZipCode (ZipCode) VALUES ('70115'); --4
INSERT INTO ZipCode (ZipCode) VALUES ('70116'); --5
INSERT INTO ZipCode (ZipCode) VALUES ('70117'); --6
INSERT INTO ZipCode (ZipCode) VALUES ('70118'); --7
INSERT INTO ZipCode (ZipCode) VALUES ('70119'); --8

-----NEED TO WORK ON
INSERT INTO ZipCode (ZipCode) VALUES ('70124'); --9
INSERT INTO ZipCode (ZipCode) VALUES ('70125'); --10
INSERT INTO ZipCode (ZipCode) VALUES ('70126'); --11
INSERT INTO ZipCode (ZipCode) VALUES ('70127'); --12
INSERT INTO ZipCode (ZipCode) VALUES ('70128'); --13
INSERT INTO ZipCode (ZipCode) VALUES ('70129'); --14
INSERT INTO ZipCode (ZipCode) VALUES ('70130'); --15
INSERT INTO ZipCode (ZipCode) VALUES ('70131'); --16



/****** Object:  Table dbo.Neighborhood  ******/
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Algeirs Point', '3'); --70114
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Audubon', '4'); --70115
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Audubon', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Audubon', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('B. W. Cooper', '2'); --70113
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('B. W. Cooper', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Behrman', '3'); --70114
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Black Pearl', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Broadmoor', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Bywater', '6'); --70117
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Bywater', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Central Business District', '1'); --70112
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Central Business District', '2'); --70113
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Central Business District', '70130');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Central City', '2'); --70113
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Central City', '4'); --70115
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Central City', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Central City', '70130');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('City Park', '8'); --70119
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('City Park', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('City Park', '70124');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Desire', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Desire', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Dillard', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Dixon', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('East Carollton', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Fillmore', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Fillmore', '70124');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('French Quarter', '1'); --70112
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('French Quarter', '5'); --70116
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('French Quarter', '70130');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Freret', '4'); --70115
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Freret', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Garden District', '4'); --70115
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Garden District', '70130');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Gentilly Terrace', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Gentilly Woods', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Gert Town', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Gert Town', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Holly Grove', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Holy Cross', '6'); --70117
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Irish Channel', '4'); --70115
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Irish Channel', '70130');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lake Catherine', '70129');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lake Shore-Lake Vista', '70124');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lake Terrace and Oaks', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lake Terrace and Oaks', '70124');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lake Terrace and Oaks', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lakeview', '70124');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lakewood', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lakewood', '70124');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Leonidas', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Little Woods', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Little Woods', '70127');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Little Woods', '70128');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Little Woods', '70129');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lower Garden District', '70130');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lower Ninth Ward', '70032');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lower Ninth Ward', '6'); --70117
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lower Ninth Ward', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lower Ninth Ward', '70129');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Marlyville-Fontainebleau', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Marlyville-Fontainebleau', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Mid-City', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Mid-City', '8'); --70119
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Mid-City', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Milan', '4'); --70115
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Milan', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Milneburg', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Navarre', '7'); --70118
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Navarre', '8'); --70119
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Navarre', '70124');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Old Aurora', '3'); --70114
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Old Aurora', '70131');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Pines Village', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Plum Orchard', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Pontchartrain', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Read Blvd. East', '70127');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Read Blvd. West', '70127');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Read Blvd. West', '70128');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Seventh Ward', '70116');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Seventh Ward', '4'); --70117
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Seventh Ward', '8'); --70119
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('St. Anthony', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('St. Bernard', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('St. Claude', '6'); --70117
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('St. Roch', '6'); --70117
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('St. Roch', '8'); --70119
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('St. Roch', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Tremé / Lafitte', '1'); --70112
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Tremé / Lafitte', '70116');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Tremé / Lafitte', '8'); --70119
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Tulane - Gravier', '1'); --70112
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Tulane - Gravier', '2'); --70113
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Tulane - Gravier', '8'); --70119
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Tulane - Gravier', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Uptown', '4'); --70115
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Viavant-Venetian Isles', '6'); --70117
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Viavant-Venetian Isles', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Viavant-Venetian Isles', '70127');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Viavant-Venetian Isles', '70129');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Village De L''Est', '70128');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Village De L''Est', '70129');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('West End', '70124');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('West Lake Forest', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('West Lake Forest', '70127');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('West Riverside', '4'); --70115
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('West Riverside', '7'); --70118


/****** Object:  Table dbo.Property  ******/
INSERT INTO Property (Property) VALUES ('Single Family Home');
INSERT INTO Property (Property) VALUES ('Duplex/Double');
INSERT INTO Property (Property) VALUES ('Townhouse');
INSERT INTO Property (Property) VALUES ('Apt Complex/Garden Walkup');


/****** Object:  Table dbo.Role  ******/
INSERT INTO Role (Role, Description) VALUES ('Admin', 'An Admin can sign up, sign in, manage users and properties');
INSERT INTO Role (Role, Description) VALUES ('Tenant', 'A Tenant can sign up, sign in, edit profile and view landlord properties');
INSERT INTO Role (Role, Description) VALUES ('Landlord', 'A Landlord can sign up, sign in, edit profile, and manage properties');


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