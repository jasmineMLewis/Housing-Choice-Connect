USE HousingChoiceConnect;
GO

/****** 
Tables: 6
- Amentity
- Neighborhood
- Property
- Role
- SecurityQuestion
- Unit
******/

/****** Object:  Table dbo.Amentity  ******/
INSERT INTO Amentity (Amentity, Location) VALUES ('Central Air/Heat', 'Indoor');
INSERT INTO Amentity (Amentity, Location) VALUES ('Washer', 'Indoor');
INSERT INTO Amentity (Amentity, Location) VALUES ('Dryer', 'Indoor');
INSERT INTO Amentity (Amentity, Location) VALUES ('Alarm', 'Indoor');
INSERT INTO Amentity (Amentity, Location) VALUES ('Washer.Dryer Hookups', 'Indoor');
INSERT INTO Amentity (Amentity, Location) VALUES ('Ceiling Fans', 'Indoor');
INSERT INTO Amentity (Amentity, Location) VALUES ('Dishwasher', 'Kitchen');
INSERT INTO Amentity (Amentity, Location) VALUES ('Refrigerator', 'Kitchen');
INSERT INTO Amentity (Amentity, Location) VALUES ('Garbage Disposal', 'Kitchen');
INSERT INTO Amentity (Amentity, Location) VALUES ('Off Street Parking', 'Outdoor');
INSERT INTO Amentity (Amentity, Location) VALUES ('Covered Parking', 'Outdoor');
INSERT INTO Amentity (Amentity, Location) VALUES ('Front Yard', 'Outdoor');
INSERT INTO Amentity (Amentity, Location) VALUES ('Back Yard', 'Outdoor');
INSERT INTO Amentity (Amentity, Location) VALUES ('Gated', 'Outdoor');
INSERT INTO Amentity (Amentity, Location) VALUES ('On Site Security', 'Other');


/****** Object:  Table dbo.Neighborhood  ******/
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Algeirs Point', '70114');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Audubon', '70115');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Audubon', '70118');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Audubon', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('B. W. Cooper', '70113');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('B. W. Cooper', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Behrman', '70114');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Black Pearl', '70118');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Broadmoor', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Bywater', '70117');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Bywater', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Central Business District', '70112');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Central Business District', '70113');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Central Business District', '70130');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Central City', '70113');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Central City', '70115');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Central City', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Central City', '70130');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('City Park', '70119');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('City Park', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('City Park', '70124');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Desire', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Desire', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Dillard', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Dixon', '70118');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('East Carollton', '70118');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Fillmore', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Fillmore', '70124');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('French Quarter', '70112');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('French Quarter', '70116');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('French Quarter', '70130');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Freret', '70115');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Freret', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Garden District', '70115');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Garden District', '70130');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Gentilly Terrace', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Gentilly Woods', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Gert Town', '70118');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Gert Town', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Holly Grove', '70118');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Holy Cross', '70117');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Irish Channel', '70115');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Irish Channel', '70130');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lake Catherine', '70129');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lake Shore-Lake Vista', '70124');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lake Terrace and Oaks', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lake Terrace and Oaks', '70124');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lake Terrace and Oaks', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lakeview', '70124');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lakewood', '70118');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lakewood', '70124');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Leonidas', '70118');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Little Woods', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Little Woods', '70127');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Little Woods', '70128');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Little Woods', '70129');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lower Garden District', '70130');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lower Ninth Ward', '70032');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lower Ninth Ward', '70117');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lower Ninth Ward', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Lower Ninth Ward', '70129');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Marlyville-Fontainebleau', '70118');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Marlyville-Fontainebleau', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Mid-City', '70118');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Mid-City', '70119');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Mid-City', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Milan', '70115');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Milan', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Milneburg', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Navarre', '70118');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Navarre', '70119');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Navarre', '70124');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Old Aurora', '70114');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Old Aurora', '70131');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Pines Village', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Plum Orchard', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Pontchartrain', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Read Blvd. East', '70127');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Read Blvd. West', '70127');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Read Blvd. West', '70128');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Seventh Ward', '70116');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Seventh Ward', '70117');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Seventh Ward', '70119');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('St. Anthony', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('St. Bernard', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('St. Claude', '70117');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('St. Roch', '70117');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('St. Roch', '70119');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('St. Roch', '70122');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Tremé / Lafitte', '70112');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Tremé / Lafitte', '70116');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Tremé / Lafitte', '70119');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Tulane - Gravier', '70112');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Tulane - Gravier', '70113');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Tulane - Gravier', '70119');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Tulane - Gravier', '70125');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Uptown', '70115');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Viavant-Venetian Isles', '70117');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Viavant-Venetian Isles', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Viavant-Venetian Isles', '70127');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Viavant-Venetian Isles', '70129');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Village De L''Est', '70128');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('Village De L''Est', '70129');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('West End', '70124');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('West Lake Forest', '70126');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('West Lake Forest', '70127');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('West Riverside', '70115');
INSERT INTO Neighborhood (Neighborhood, ZipCode) VALUES ('West Riverside', '70118');


/****** Object:  Table dbo.Property  ******/
INSERT INTO Property (Property) VALUES ('Single Family Home');
INSERT INTO Property (Property) VALUES ('Duplex/Double');
INSERT INTO Property (Property) VALUES ('Townhouse');
INSERT INTO Property (Property) VALUES ('Apt Complex/Garden Walkup');


/****** Object:  Table dbo.Role  ******/
INSERT INTO Role (Role) VALUES ('Admin');
INSERT INTO Role (Role) VALUES ('Tenant');
INSERT INTO Role (Role) VALUES ('Landlord');


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