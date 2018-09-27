-- -- -------------------------------------------------------------------------------
-- -- Zadanie 8
-- -- -------------------------------------------------------------------------------

-- -- -------------------------------------------------------------------------------
-- Section: setting sql_mode
-- -- -------------------------------------------------------------------------------

SET sql_mode='ONLY_FULL_GROUP_BY,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

-- -- -------------------------------------------------------------------------------
-- Section: USE
-- Zamien 'jsk_v7_jan_kowalski' na poprawna nazwe Twojej bazy danych
-- -- -------------------------------------------------------------------------------
USE jsk_v7_jan_kowalski;

-- -- -------------------------------------------------------------------------------
-- Section: rozwiazanie zadania
-- -- -------------------------------------------------------------------------------

-- a)	załóż 2 indeksy na wybranych przez siebie kolumnach

-- 1)

CREATE INDEX IX_t_customer_NAME_SURNAME ON t_customer (NAME,SURNAME);

-- 2)

CREATE INDEX IX_t_rent_CUSTOMER_ID_RENT_COST ON t_rent (CUSTOMER_ID,RENT_COST);

-- b)	uzasadnij dlaczego tam powinny się znaleźć (odpowiedz komentarzem poniżej)

-- Te indexy powinny się tam znalezc poniewaz, w realnych bazach danych bardzo czesto wykorzystuje sie imie i nazwisko do wyszukiwania danych klienta, 
-- a w drugim przypadku index może być przydatny podczas rozliczania kosztow dla danego klienta

-- c)	jakie są pozytywne a jakie negatywne skutki zastosowania indeksów?

-- Do zalet stosowania indexow na pewno zalicza sie przyspieszenie wyszukiwania informacji przy rozbudowanych bazach danych, 
-- jednakże wadą stosowania indexow jest spowolenienie operacji modyfikacji danej tabeli
