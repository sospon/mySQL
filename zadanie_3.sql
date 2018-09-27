-- -- -------------------------------------------------------------------------------
-- -- Zadanie 3
-- -- -------------------------------------------------------------------------------

-- -- -------------------------------------------------------------------------------
-- Section: setting sql_mode
-- -- -------------------------------------------------------------------------------

SET sql_mode='ONLY_FULL_GROUP_BY,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -- -------------------------------------------------------------------------------
-- Section: USEclientrentviewclientrentview
-- Zamien 'jsk_v7_jan_kowalski' na poprawna nazwe Twojej bazy danych
-- -- -------------------------------------------------------------------------------
USE jsk_v7_bartosz_passon;

-- -- -------------------------------------------------------------------------------
-- Section: rozwiazanie zadania
-- -- -------------------------------------------------------------------------------
CREATE OR REPLACE VIEW v_clientrent
AS SELECT b.CUSTOMER_ID, a.NAME, a.SURNAME, b.STARTING_DATE, b.FINISH_DATE, c.BRAND, c.MODEL, b.RENT_COST as costs
FROM t_customer a, t_rent b, t_car c
WHERE a.customer_id=b.customer_id
AND c.car_id=b.car_id;

