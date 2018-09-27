-- -- -------------------------------------------------------------------------------
-- -- Zadanie 6
-- -- -------------------------------------------------------------------------------

-- -- -------------------------------------------------------------------------------
-- Section: setting sql_mode
-- -- -------------------------------------------------------------------------------

SET sql_mode='ONLY_FULL_GROUP_BY,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -- -------------------------------------------------------------------------------
-- Section: USE
-- Zamien 'jsk_v7_jan_kowalski' na poprawna nazwe Twojej bazy danych
-- -- -------------------------------------------------------------------------------
USE jsk_v7_bartosz_passon;

-- -- -------------------------------------------------------------------------------
-- Section: rozwiazanie zadania
-- -- -------------------------------------------------------------------------------

CREATE trigger insert_amount_trigger BEFORE INSERT ON t_rent
for each row
set NEW.RENT_COST = IF(NEW.RENT_COST <100, 100, NEW.RENT_COST);

insert into t_rent (CAR_ID, CUSTOMER_ID, STARTING_DATE, FINISH_DATE, COMPANY_ID_START, COMPANY_ID_FINISH, RENT_COST) 
values (39, 1, '2018-08-05', '2018-08-07', 3, 1, 50);

select * from t_rent; 

Create trigger update_amount_trigger Before Update On t_rent
for each row
set NEW.RENT_COST = IF(NEW.RENT_COST <100, 100, NEW.RENT_COST);

UPDATE t_rent
SET RENT_COST = '80'
where RENT_ID = 100;

select * from t_rent;


show triggers;

drop trigger amount_trigger;