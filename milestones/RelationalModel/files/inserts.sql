-- Script name: inserts.sql
-- Author:      Zi Collin Zhen
-- Purpose:     insert sample data to test the integrity of this database system

-- !!!!If there's an error, please reference hotelmanagementdbmodel.sql - DROP DATABASE HotelManagementDB comment!!!!

-- the database used to insert the data into.
USE HotelManagementDB;

-- Employee table inserts
INSERT INTO employee (employee_id, email, ssn, name) VALUES (1, 'kiddailey@sbcglobal.net', '680-40-1262', 'Rishi Heath'), (2, 'nichoj@sbcglobal.net', '040-98-7647', 'Talhah Muir'), 
(3, 'grinder@att.net', '574-82-7396', 'Kymani Cervantes'),(4, 'afeldspar@gmail.com', '321-28-1580', 'Teddie Tate'),(5, 'luebke@yahoo.ca', '592-18-5202', 'Milo Cohen'),
(6, 'cremonini@me.com', '601-59-0348', 'Mathilda Gomez'),(7, 'miltchev@optonline.net', '397-03-8206', 'Rudi Roy'),(8, 'jmorris@icloud.com', '404-37-6433', 'Diesel Schwartz'),(9, 'ahmad@outlook.com', '505-60-2710', 'Olivia-Grace David'),
(10, 'dburrows@me.com', '430-44-4642', 'Marcus Salt'),(11, 'kawasaki@yahoo.ca', '530-83-2948', 'Faizaan Jaramillo'),(12, 'rddesign@yahoo.ca', '601-42-2183', 'Shannan Collier'),
(13, 'rattenbt@verizon.net', '008-58-7747', 'Darien Duffy'),(14, 'emmanuel@yahoo.com', '042-22-6006', 'Safiyah Woodcock'),(15, 'rgarcia@att.net', '411-78-1574', 'Pooja English'),
(16, 'maratb@optonline.net', '266-57-6869', 'Sanjeev Hills'),(17, 'yfreund@me.com', '658-03-4479', 'Weronika French'),(18, 'tromey@live.com', '574-05-9236', 'Mariam Romero'),
(19, 'hermanab@msn.com', '523-71-9389', 'Callan Bullock'),(20, 'rnewman@outlook.com', '530-82-6792', 'Lindsay Bowler'),(21, 'dodong@att.net', '652-48-8274', 'Melody Ramsey');

-- chef table inserts
INSERT INTO chef (chef_id, employee, name) VALUES (1, 1, 'Rishi Heath'),(2,2,'Talhah Muir'),(3,3,'Kymani Cervantes');

-- engineer table inserts
INSERT INTO engineer (engineer_id, employee, name) VALUES (1, 4,'Teddie Tate'),(2,5,'Milo Cohen'),(3,6,'Mathilda Gomez');

-- housekeeper table inserts
INSERT INTO housekeeper (housekeeper_id, employee, name) VALUES(1,7,'Rudi Roy'),(2,8,'Diesel Schwartz'),(3,9,'Olivia-Grace David');

-- supervisor table inserts
INSERT INTO supervisor (supervisor_id, employee, name) VALUES(1,10,'Marcus Salt'),(2,11,'Faizaan Jaramillo'),(3,12,'Shannan Collier');

-- receptionClerk table inserts
INSERT INTO receptionClerk (receptionClerk_id, employee, name) VALUES(1,13,'Darien Duffy'),(2,14,'Safiyah Woodcock'),(3,15,'Pooja English');

-- manager table inserts
INSERT INTO manager (manager_id, employee, name) VALUES(1,16,'Sanjeev Hills'),(2,17,'Weronika French'),(3,18,'Mariam Romero');

-- roomServicePorter table inserts
INSERT INTO roomServicePorter (roomServicePorter_id, employee, name) VALUES(1,19,'Callan Bullock'),(2,20,'Lindsay Bowler'),(3,21,'Melody Ramsey');

-- hourlyWage table inserts
INSERT INTO hourlyWage(employee, money) VALUE(1,1000),(2,1000),(3,1000),(4,500),(5,500),(6,500),(7,999),(8,999),(9,999),(10,200),(11,200);

-- hoursWorked table inserts
INSERT INTO hoursWorked(employee, money) VALUE(12,200),(13,400),(14,400),(15,400),(16,600),(17,600),(18,600),(19,2000),(20,2000),(21,22000);

-- registerListing table inserts
INSERT INTO registerListing(employee, owner) VALUE(1,1),(2,1),(3,1);

-- owner table inserts
INSERT INTO owner(owner_id, name, email) VALUE(1,'Abby Murray','hmbrand@aol.com'),(2,'Mitchell Bateman','mschilli@comcast.net'),(3,'Hadley Driscoll','philen@yahoo.com');

-- account table inserts
INSERT INTO account (account_id, employee, type, password, created, guest) VALUES (1,1,2,'123456789','2020-05-18',0),(2,2,2,'asdfasd23','2020-02-11',0),(3,0,1,'jasldkjf23','2019-09-01',1);

-- accountType table inserts
INSERT INTO accountType (account_type_id, description) VALUES (1,'Guest Account'),(2,'Employee Account'),(3,'Manager Acccount');

-- supportedFeature table inserts
INSERT INTO supportedFeature (supportedFeature_id, account_type, feature, feedback) VALUES(1,1,1,1),(2,2,2,2),(3,3,3,3);

-- feedback table inserts
INSERT INTO feedback (feedback_id, description, rating) VALUES(1,'fantastic hotel', 5),(2, 'ok hotel', 3),(3, 'decent hotel to stay', 3);

-- feature table inserts
INSERT INTO feature (feature_id, description) VALUES (1,'Guest Features'),(2,'Employee Features'),(3,'Manager features');

-- department table inserts
INSERT INTO department (department_id, description) VALUES(1,'Motel Department'),(2,'Hotel Department'),(3,'Resort Department');

-- engineering table inserts
INSERT INTO engineering (engineering_id, department, name, budget) VALUE (1,1,'Team A',100000),(2,2,'Team A',100000),(3,3,'Team A',100000);

-- foodAndBeverage table inserts
INSERT INTO foodAndBeverage (foodAndBeverage_id, department, name, budget) VALUE(1,1,'Team B',100000),(2,2,'Team B',100000),(3,3,'Team B',100000);

-- humanResource table inserts
INSERT INTO humanResource (humanResource_id, department, name, budget) VALUE(1,1,'Team C',100000),(2,2,'Team C',100000),(3,3,'Team C',100000);

-- salesAndMarketing table inserts
INSERT INTO salesAndMarketing (salesAndMarketing_id, department, name, budget) VALUE(1,1,'Team D',100000),(2,2,'Team D',100000),(3,3,'Team D',100000);

-- accounting table inserts
INSERT INTO accounting (accounting_id, department, name, budget) VALUE(1,1,'Team E',100000),(2,2,'Team E',100000),(3,3,'Team E',100000);

-- roomDivision table inserts
INSERT INTO roomDivision (roomDivision_id, department, name, budget) VALUE(1,1,'Team F',100000),(2,2,'Team F',100000),(3,3,'Team F',100000);

-- gym table inserts
INSERT INTO gym (gym_id, gymName) VALUE(1, 'Raise the Bar Fitness'),(2,'Fit Club'),(3,'Planet Fitness');

-- recreationCenter table inserts
INSERT INTO recreationCenter (recreationCenter_id, recreationCenterName) VALUE(1, 'Minnie and Lovie'),(2,'Potrero Hill'),(3,'Koret Health');

-- pool table inserts
INSERT INTO pool (pool_id, num_of_ppl, time_limit) VALUE(1, 25,60),(2, 50, 60),(3, 100,180);

-- tennisCourt table inserts
INSERT INTO tennisCourt (tennisCourt_id, tennisCourtName) VALUE(1, 'Tenacious Tennis Academy'),(2,'McCoppin Park Tennis Courts'),(3,'GGP Tennis Partners');

-- clothingStore table inserts
INSERT INTO clothingStore (clothingStore_id, store_brand_name ) VALUE(1,'Nike'),(2,'Adidas'),(3,'Gucci');

-- hairSaloon table inserts
INSERT INTO hairSaloon(hairSaloon_id, hairSaloonName, rating) VALUE(1,'Perfect Cut Hair Salon',3),(2,'Ken & Mary Hair Salon',4),(3,'A and k Hair Salon',5);

-- movieTheater table inserts
INSERT INTO movieTheater(movieTheater_id, movieTheaterName,num_movie) VALUE(1,'Four Star Theatre',10),(2,'CineArts at the Empire',15),(3,'AMC Metreon 16',20);

-- jewelryStore table inserts
INSERT INTO jewelryStore(jewelryStore_id,jewelryStoreName, priceRange) VALUE(1,'Geoffreys Diamonds & Goldsmith','medium'),(2,'Kay Jewelers','high'),(3,'Pandora','low');

-- buffet table inserts
INSERT INTO buffet(buffet_id, buffetName, rating ) VALUE(1,'Fiery Hot Pot Buffet',5),(2,'Moonstar',5),(3,'Julies Kitchen',4);

-- restaurant table inserts
INSERT INTO restaurant(restaurant_id, restaurantName, rating) VALUE(1,'Dumpling Kitchen',4),(2,'Toyose',4),(3,'Hongs Kitchen',4);

-- bar table inserts
INSERT INTO bar(bar_id, barName, rating) VALUE(1,'Flanahans Pub',4),(2,'Fire Fly Sports Bar',4),(3,'The Riptide',4);

-- lounge table inserts
INSERT INTO lounge(lounge_id, loungeName, rating) VALUE(1,'Boomerang Cocktail Lounge',3),(2,'Buddha Lounge',5),(3,'Lush Lounge',4);

-- establishment table inserts
INSERT INTO establishment(establishment_id, employee, hotelType,department) VALUE(1,1,1,1),(2,2,2,2),(3,3,3,3);

-- hotelType table inserts
INSERT INTO hotelType(hotelType_id, hotel_type_name,num_room) VALUE(1,'Staypineapple',100),(2,'Holiday Inn',200),(3,'Dream Resort',50);

-- location table inserts
INSERT INTO location(location_id,locationName, locale, hotelType ) VALUE(1,'San Francisco',1,1),(2,'New York',2,2),(3,'Florida',3,3);

-- supportedFacility table inserts
INSERT INTO supportedFacility(supportedFacility_id, hotelType,gym,spa,pool,tennisCourt) VALUE(1,1,1,1,1,1),(2,2,2,2,2,2),(3,3,3,3,3,3);

-- locale table inserts
INSERT INTO locale(locale_id,location_name ) VALUE(1,'Stonestown'),(2,'Lakeshore Plaza'),(3,'Florida Centre');

-- foodVendor table inserts
INSERT INTO foodVendor(foodVendor_id, locale, bar, restaurant, lounge, buffet) VALUE(1,1,1,1,1,1),(2,2,2,2,2,2),(3,3,3,3,3,3);

-- serviceAndRetailVendor table inserts
INSERT INTO serviceAndRetailVendor(serviceAndRetailVendor_id, locale, movieTheater, hairSaloon, clothingStore, jewelryStore) VALUE(1,1,1,1,1,1),(2,2,2,2,2,2),(3,3,3,3,3,3);

-- tourist table inserts
INSERT INTO tourist(tourist_id, touristCountry, locale) VALUE(1, 'China', 1),(2, 'Africa', 2),(3,'Europe',3);

-- databaseSystem table inserts
INSERT INTO databaseSystem(database_id, guest, created, account ) VALUE(1,1,'2020-05-11',1),(2,2,'2020-05-02',2),(3,3,'2020-05-09',3);

-- guests table inserts
INSERT INTO guest(guest_id, name,email,address,post_code,phone,city,state,country) VALUE(1, 'Jesse M Arellano', 'jackolantern@gmail.com','2412 Carter Street', '62220', '618-825-2166','Belleville','IL','United State'),
(2, 'Jeffrey L Hart', 'guapamente@pacifiersshop.life','4319  Shingleton Road', '49007', '269-337-1183','Kalamazoo','MI','United State'),
(3, 'Marie J Beach', 'tklifedqbms@temporary-mail.net','1347  Concord Street', '92369', '704-579-0063','PATTON','CA','United State');

-- room table inserts
INSERT INTO room(room_id,to_date,from_date,roomCategory,guest ) VALUE(1,'2020-05-11','2020-05-15',1,1),(2,'2020-05-02','2020-05-28',2,2),(3,'2020-05-09','2020-05-17',3,3);

-- roomCategory table inserts
INSERT INTO roomCategory(roomCategory_id,name, hotel, guest ) VALUE(1,1,1,1),(2,2,2,2),(3,3,3,3);

-- billingInfo table inserts
INSERT INTO billingInfo(billingInfo_id, invoice, deliveryService, guest, amount ) VALUE(1,1,1,1,45.45),(2,2,2,2,420.45),(3,3,3,3,67.69);

-- deliveryService table inserts
INSERT INTO deliveryService(deliveryService_id, deliveryServiceName) VALUE(1,'Food Delivery'),(2,'Laundry Delivery'),(3,'Amenities Delivery');

-- laundryOrder table inserts
INSERT INTO laundryOrder(laundryOrder_id,order_date,clothe, deliveryService ) VALUE(1,'2020-05-15',1,1),(2,'2020-05-02',2,2),(3,'2020-05-09',3,3);

-- clothe table inserts
INSERT INTO clothe(clothe_id, clotheName, size , price) VALUE(1,'T-Shirt', 'Big', 15),(2,'Jeans','Xtra Large', 40),(3,'Sweater', 'Small', 15);

-- foodOrder table inserts
INSERT INTO foodOrder(foodOrder_id, order_date,meal, deliveryService ) VALUE(1,'2020-05-15',1,1),(2,'2020-06-15',2,2),(3,'2020-07-15',3,3);

-- meal table inserts
INSERT INTO meal(meal_id, mealName, price ) VALUE(1,'Sushi', 40),(2,'Burger',10),(3,'Spaghetti and Meat Balls',20);

-- invoice table inserts
INSERT INTO invoice(invoice_id, status, description) VALUE(1,'Paid','Your balance has been paid.'),(2,'Paid','Your balance has been paid.'),(3,'Overdue','Your balance is overdue for two days.');

-- invoiceInfo table inserts
INSERT INTO invoiceInfo(invoiceInfo_id, paymentType,invoice) VALUE(1,1,1),(2,2,2),(3,3,3);

-- paymentType table inserts
INSERT INTO paymentType(paymentType_id,address,zip_code,country,state,city ) VALUE(1,'2342 Sanputo St.', '23422', 'Africa', 'AF', 'Fan Fan'),(2,'5322 John St.', '22232', 'United Nation', 'UN', 'Izan'),(3,'542 Wonder St.', '2343', 'United States of America', 'CA', 'San Francisco');

-- creditCard table inserts
INSERT INTO creditCard(payment_type,card_number,bank,exp_date,cvv ) VALUE(1,'368194405088870','American Express','2022-11-23',121),(2,'5589981337500028','MasterCard','2022-11-23',555),(3,'4877187570129','Visa', '2022-11-23',333);

-- bankAccount table inserts
INSERT INTO bankAccount(payment_type, acc_number, bank, routing ) VALUE(1,'565777','Bank of America','021000021'),(2,'482917','Chase','011401533'),(3,'262654','Well Fargo','091000019');

-- editReservation table inserts
INSERT INTO editReservation(editReservation_id, room, cancel, date, price, guest ) VALUE(1,50,1,'2020-06-15',22,1),(2,33,33,'2020-05-15',33,2),(3,44,44,'2020-04-15',44,3);

-- priceCategory table inserts
INSERT INTO priceCategory(priceCategory_id,availableRoom,price,hotel,date ) VALUE(1,1,23,2,'2020-05-15'),(2,22,2,2,'2020-06-15'),(3,2,2,2,'2020-07-15') ;
