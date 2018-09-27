-- -- -------------------------------------------------------------------------------
-- -- Zadanie 5
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

DROP FUNCTION IF EXISTS find_most_rent_for_customer;

delimiter //

create function find_most_rent_for_customer(ind integer)
returns char(10)
deterministic
begin
declare rm varchar(10);
Select concat(YEAR(STARTING_DATE), "-", MONTH(STARTING_DATE)) as month_year
into rm
from t_rent
where CUSTOMER_ID=ind
group by month_year
order by count(month_year) desc
limit 1;
Return Cast(rm as char);
End //
delimiter ;


Select CUSTOMER_ID, NAME, SURNAME, find_most_rent_for_customer(t_customer.CUSTOMER_ID) as most_rents_in_date 
from t_customer
where find_most_rent_for_customer(CUSTOMER_ID) is not null
group by CUSTOMER_ID;

