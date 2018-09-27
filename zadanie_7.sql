-- -- -------------------------------------------------------------------------------
-- -- Zadanie 7
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

-- a)	użytkownik user_ro może tylko odczytywać dane z wszystkich tabel

CREATE USER 'user_ro'@'localhost:3306' identified by '1234';

GRANT SELECT ON jsk_v7_bartosz_passon.* TO 'user_ro'@'localhost:3306';

-- b)	użytkownik user_rw_adres ma pełny dostęp do tabeli z adresami (tzn. może wstawiać i usuwać dane), do innych tabel w projekcie ma tylko prawo odczytu

CREATE USER 'user_rw'@'localhost:3306' identified by '1234';

GRANT INSERT, UPDATE, DELETE ON jsk_v7_bartosz_passon.t_adress TO 'user_rw'@'localhost:3306';

GRANT SELECT ON jsk_v7_bartosz_passon.* TO 'user_rw'@'localhost:3306';

-- c)	użytkownik user_admin ma pełny dostęp do wszystkich uprawnień

CREATE USER 'user_admin'@'localhost:3306' identified by '1234';

GRANT ALL PRIVILEGES ON jsk_v7_bartosz_passon.* TO 'user_admin'@'localhost:3306';