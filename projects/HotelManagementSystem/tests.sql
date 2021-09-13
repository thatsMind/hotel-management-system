   -- Script name: inserts.sql
   -- Author:      Zi Collin Zhen
   -- Purpose:     update or delete sample data to test the integrity of this database system
   
    -- the database used to insert the data into.
   USE HotelManagementDB; 
   
   SET SQL_SAFE_UPDATES = 0; -- so I can access non-primary keys such as name
   
   -- 1. Testing Employee table
   DELETE FROM employee WHERE name = 'Rishi Heath';
   UPDATE employee SET employee_id = 0 WHERE name = 'Talhah Muir';
   
   -- 2. Testing chef table
   DELETE FROM chef WHERE name = 'Rishi Heath';
   UPDATE chef SET chef_id = 0 WHERE name = 'Talhah Muir';
   
   -- 3. Testing engineer table
   DELETE FROM engineer WHERE name = 'Teddie Tate';
   UPDATE engineer SET engineer_id = 0 WHERE name = 'Milo Cohen';
   
   -- 4. Testing housekeeper table
   DELETE FROM housekeeper WHERE name = 'Rudi Roy';
   UPDATE housekeeper SET housekeeper_id = 0 WHERE name = 'Diesel Schwartz';
   
      -- 5. Testing supervisor table
   DELETE FROM supervisor WHERE name = 'Marcus Salt';
   UPDATE supervisor SET supervisor_id = 0 WHERE name = 'Faizaan Jaramillo';
   
      -- 6. Testing receptionClerk table
   DELETE FROM receptionClerk WHERE name = 'Darien Duffy';
   UPDATE receptionClerk SET receptionClerk_id = 0 WHERE name = 'Safiyah Woodcock';
   
      -- 7. Testing manager table
   DELETE FROM manager WHERE name = 'Sanjeev Hills';
   UPDATE manager SET manager_id = 0 WHERE name = 'Weronika French';
   
      -- 8. Testing roomServicePorter table
   DELETE FROM roomServicePorter WHERE name = 'Callan Bullock';
   UPDATE roomServicePorter SET roomServicePorter_id = 0 WHERE name = 'Lindsay Bowler';
   
   -- 9. Testing hourlyWage table
	DELETE FROM hourlyWage WHERE employee = 1;
   -- UPDATE hourlyWage SET employee = 0 WHERE money = 1000; -- Error Code: 1062. Duplicate entry '0' for key 'hourlywage.PRIMARY' Possible Solution: updating multiple primary variables with the ssame value, should be non-primary instead.
   
     -- 10. Testing hoursWorked table
	DELETE FROM hoursWorked WHERE employee = 12;
   UPDATE hoursWorked SET money = 0 WHERE money = 400;
   
      -- 11. Testing registerListing table
   DELETE FROM registerListing WHERE employee = 1;
   UPDATE registerListing SET owner = 2 WHERE owner = 1;
      
      -- 12. Testing owner table
   DELETE FROM owner WHERE name = 'Abby Murray';
   UPDATE owner SET owner_id = 0 WHERE name = 'Mitchell Bateman';
      
      -- 13. Testing account table
   DELETE FROM account WHERE password = '123456789';
   UPDATE account SET account_id = 0 WHERE created = '2020-02-11';
      
      -- 14. Testing accountType table
   DELETE FROM accountType WHERE description = 'Guest Account';
   UPDATE accountType SET account_type_id = 0 WHERE description = 'Employee Account';
      
      -- 15. Testing supportedFeature   table
   DELETE FROM supportedFeature   WHERE supportedFeature_id = 1;
   UPDATE supportedFeature   SET feature = 0 WHERE feedback = 2;
      
      -- 16. Testing feedback table
   DELETE FROM feedback WHERE description ='fantastic hotel';
   UPDATE feedback SET feedback_id = 0 WHERE description = 'ok hotel';
   
   -- 17. Testing restaurant table
   DELETE FROM restaurant WHERE restaurantName = 'Dumpling Kitchen';
   UPDATE restaurant SET restaurant_id = 0 WHERE restaurantName = 'Toyose';

   -- 18. Testing bar table
   DELETE FROM bar WHERE barName = 'Flanahans Pub';
   UPDATE bar SET bar_id = 0 WHERE barName = 'Fire Fly Sports Bar';

   -- 19. Testing lounge table
   DELETE FROM lounge WHERE loungeName = 'Boomerang Cocktail Lounge';
   UPDATE lounge SET lounge_id = 0 WHERE loungeName = 'Buddha Lounge';

   -- 20. Testing establishment table
   DELETE FROM establishment WHERE establishment_id = 1;
   UPDATE establishment SET establishment_id = 0 WHERE establishment_id = 2;

   -- 21. Testing hotelType table
   DELETE FROM hotelType WHERE hotel_type_name = 'Staypineapple';
   UPDATE hotelType SET hotelType_id = 0 WHERE hotel_type_name = 'Holiday Inn';

   -- 22. Testing location table
   DELETE FROM location WHERE locationName = 'San Francisco';
   UPDATE location SET location_id = 0 WHERE locationName = 'New York';

   -- 23. Testing supportedFacility table
   DELETE FROM supportedFacility WHERE supportedFacility_id = 1;
   UPDATE supportedFacility SET supportedFacility_id = 0 WHERE supportedFacility_id = 2;

   -- 24. Testing locale table
   DELETE FROM locale WHERE location_name = 'Stonestown';
   UPDATE locale SET locale_id = 0 WHERE location_name = 'Lakeshore Plaza';

   -- 25. Testing foodVendor table
   DELETE FROM foodVendor WHERE foodVendor_id = 1;
   UPDATE foodVendor SET foodVendor_id = 0 WHERE foodVendor_id = 2;

   -- 26. Testing serviceAndRetailVendor table
   DELETE FROM serviceAndRetailVendor WHERE serviceAndRetailVendor_id = 1;
   UPDATE serviceAndRetailVendor SET serviceAndRetailVendor_id = 0 WHERE serviceAndRetailVendor_id = 2;

   -- 27. Testing databaseSystem table
   DELETE FROM databaseSystem WHERE created = '2020-05-11';
   UPDATE databaseSystem SET database_id = 0 WHERE created = '2020-05-02';

   -- 28. Testing guest table
   DELETE FROM guest WHERE name = 'Jesse M Arellano';
   UPDATE guest SET guest_id = 0 WHERE name = 'Jeffrey L Hart';

   -- 29. Testing room table
   DELETE FROM room WHERE to_date = '2020-05-11';
   UPDATE room SET room_id = 0 WHERE to_date = '2020-05-02';

   -- 30. Testing roomCategory table
   DELETE FROM roomCategory WHERE roomCategory_id = 1;
   UPDATE roomCategory SET roomCategory_id = 0 WHERE roomCategory_id = 2;

   -- 31. Testing billingInfo table
   DELETE FROM billingInfo WHERE amount = 45.45;
   UPDATE billingInfo SET billingInfo_id = 0 WHERE amount = 420.45;

   -- 32. Testing deliveryService table
   DELETE FROM deliveryService WHERE deliveryServiceName = 'Food Delivery';
   UPDATE deliveryService SET deliveryService_id = 0 WHERE deliveryServiceName = 'Laundry Delivery';

   -- 33. Testing laundryOrder table
   DELETE FROM laundryOrder WHERE order_date = '2020-05-15';
   UPDATE laundryOrder SET laundryOrder_id = 0 WHERE order_date = '2020-05-02';

   -- 34. Testing clothe table
   DELETE FROM clothe WHERE clotheName = 'T-Shirt';
   UPDATE clothe SET clothe_id = 0 WHERE clotheName = 'Jeans';

   -- 35. Testing foodOrder table
   DELETE FROM foodOrder WHERE order_date = '2020-05-15';
   UPDATE foodOrder SET foodOrder_id = 0 WHERE order_date = '2020-06-15';

   -- 36. Testing meal table
   DELETE FROM meal WHERE mealName = 'Sushi';
   UPDATE meal SET meal_id = 0 WHERE mealName = 'Burger';

   -- 37. Testing invoice table
   DELETE FROM invoice WHERE description = 'Your balance has been paid.';
   UPDATE invoice SET invoice_id = 0 WHERE description = 'Your balance is overdue for two days.';

   -- 38. Testing invoiceInfo table
   DELETE FROM invoiceInfo WHERE invoiceInfo_id = 1;
   UPDATE invoiceInfo SET invoiceInfo_id = 0 WHERE invoiceInfo_id = 2;

   -- 39. Testing paymentType table
   DELETE FROM paymentType WHERE zip_code = '23422';
   UPDATE paymentType SET paymentType_id = 0 WHERE zip_code = '22232';

   -- 40. Testing creditCard table
   DELETE FROM creditCard WHERE card_number = '368194405088870';
   UPDATE creditCard SET payment_type = 0 WHERE card_number = '5589981337500028';

   -- 41. Testing bankAccount table
   DELETE FROM bankAccount WHERE bank = 'Bank of America';
   UPDATE bankAccount SET payment_type = 0 WHERE bank = 'Chase';

   -- 42. Testing editReservation table
   DELETE FROM editReservation WHERE date = '2020-06-15';
   UPDATE editReservation SET editReservation_id = 0 WHERE date = '2020-05-15';

   -- 43. Testing priceCategory table
   DELETE FROM priceCategory WHERE date = '2020-05-15';
   UPDATE priceCategory SET priceCategory_id = 0 WHERE date = '2020-06-15';

   -- 44. Testing tourist table
   DELETE FROM tourist WHERE touristCountry = 'China';
   UPDATE tourist SET tourist_id = 0 WHERE touristCountry = 'Africa';

   -- 45. Testing feature table
   DELETE FROM feature WHERE description = 'Guest Features';
   UPDATE feature SET feature_id = 0 WHERE description = 'Employee Features';

   -- 46. Testing department table
   DELETE FROM department WHERE description = 'Motel Department';
   UPDATE department SET department_id = 0 WHERE description = 'Hotel Department';

   -- 47. Testing engineering table
   DELETE FROM engineering WHERE engineering_id = 1;
   UPDATE engineering SET name = 'Team F' WHERE budget = 100000;

   -- 48. Testing foodAndBeverage table
   DELETE FROM foodAndBeverage WHERE foodAndBeverage_id = 1;
   UPDATE foodAndBeverage SET name = 'Team E' WHERE budget = 100000;

   -- 49. Testing humanResource table
   DELETE FROM humanResource WHERE humanResource_id = 1;
   UPDATE humanResource SET name = 'Team D' WHERE budget = 100000;

   -- 50. Testing salesAndMarketing table
   DELETE FROM salesAndMarketing WHERE salesAndMarketing_id = 1;
   UPDATE salesAndMarketing SET name = 'Team C' WHERE budget = 100000;

   -- 51. Testing accounting table
   DELETE FROM accounting WHERE accounting_id = 1;
   UPDATE accounting SET name = 'Team B' WHERE budget = 100000;

   -- 52. Testing roomDivision table
   DELETE FROM roomDivision WHERE roomDivision_id = 1;
   UPDATE roomDivision SET name = 'Team A' WHERE budget = 100000;

   -- 53. Testing gym table
   DELETE FROM gym WHERE gymName = 'Raise the Bar Fitness';
   -- UPDATE gym SET gym_id = 0 WHERE gym_id = 'Fit Club'; Error Code: 1292. Truncated incorrect DOUBLE value: 'Fit Club' Possible Solution: misstype gym_id, should be gymName instead.
   
   -- 54. Testing recreationCenter table
   DELETE FROM recreationCenter WHERE recreationCenterName = 'Minnie and Lovie';
   UPDATE recreationCenter SET recreationCenter_id = 0 WHERE recreationCenterName = 'Potrero Hill';

   -- 55. Testing pool table
   DELETE FROM pool WHERE time_limit = 180;
   UPDATE pool SET num_of_ppl = 75 WHERE time_limit = 60;

   -- 56. Testing tennisCourt table
   DELETE FROM tennisCourt WHERE tennisCourtName = 'Tenacious Tennis Academy';
   UPDATE tennisCourt SET tennisCourt_id = 0 WHERE tennisCourtName = 'McCoppin Park Tennis Courts';

   -- 57. Testing clothingStore table
   DELETE FROM clothingStore WHERE store_brand_name = 'Nike';
   UPDATE clothingStore SET clothingStore_id = 0 WHERE store_brand_name = 'Adidas';

   -- 58. Testing hairSaloon table
   DELETE FROM hairSaloon WHERE hairSaloonName = 'Perfect Cut Hair Salon';
   UPDATE hairSaloon SET hairSaloon_id = 0 WHERE hairSaloonName = 'Ken & Mary Hair Salon';

   -- 59. Testing movieTheater table
   DELETE FROM movieTheater WHERE movieTheaterName = 'Four Star Theatre';
   UPDATE movieTheater SET movieTheater_id = 0 WHERE movieTheaterName = 'CineArts at the Empire';

   -- 60. Testing jewelryStore table
   DELETE FROM jewelryStore WHERE jewelryStoreName = 'Geoffreys Diamonds & Goldsmith';
   UPDATE jewelryStore SET jewelryStore_id = 0 WHERE jewelryStoreName = 'Kay Jewelers';

   -- 61. Testing buffet table
   DELETE FROM buffet WHERE buffetName = 'Fiery Hot Pot Buffet';
   UPDATE buffet SET buffet_id = 0 WHERE buffetName = 'Moonstar';


   
   
   
   
   
   

   