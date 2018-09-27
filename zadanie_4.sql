-- -- -------------------------------------------------------------------------------
-- -- Zadanie 4
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


-- 1)	wylistuj wszystkie tabele w Twojej bazie danych

-- show tables;
show full tables where Table_Type !='VIEW';

-- 2)	wyświetl informacje na temat pól i typów danych w tabeli pracowników

SHOW COLUMNS FROM t_employee;


-- 3)	znajdź pracowników starszych niż 25 lat

select NAME, SURNAME, BIRTH_DATE from t_employee
WHERE timestampdiff(YEAR, BIRTH_DATE,CURDATE()) >25;

-- 4)	znajdź pracowników, których nazwisko jest dłuższe niż 5 znaków, uwzględnij przy tym polskie znaki czy znaki specjalne

SELECT NAME, SURNAME FROM t_employee
WHERE char_length(SURNAME) > 5;

-- 5)	znajdź pracowników, w których nazwisku na drugim miejscu wystepuje litera 'a'

Select NAME, SURNAME from t_employee
where SURNAME REGEXP '^.[a]';

-- 6)	znajdź klientów, którzy posiadają e-mail, w którym na drugim miejscu local-part (znaki przed "@") nie znajduje się litera, a domeną jest ".pl" lub ".eu"

Select NAME, SURNAME, E_MAIL from t_customer
where E_MAIL REGEXP '^[a-zA-Z_0-9][0-9\.\_\-][a-zA-Z0-9\.\_\-]*@[a-zA-Z0-9]+\.(eu|pl)';

-- 7)	znajdź klientów, którzy posiadają e-mail niezgodny z przyjętym standardem formatu adresu e-mail (np. test@wp. zamiast test@wp.pl)


Select NAME, SURNAME, E_MAIL from t_customer
where E_MAIL NOT REGEXP '^[a-zA-Z_0-9][a-zA-Z0-9\.\_\-]*@[a-zA-Z0-9]+[\.][a-zA-Z][a-zA-Z]+';

-- 8)	policz ilość samochodów których przebieg jest pomiędzy 200 tys. km a 300 tys. km

SELECT COUNT(*) 
from t_car
where KM between 200000 and 300000;

-- 9)	znajdź wszystkich kierowników

select NAME, SURNAME, POSITION from t_employee
where POSITION REGEXP '^SUPERVISOR|CEO';

-- 10)	znajdź samochody z największym przebiegiem

SELECT BRAND, MODEL, KM from t_car
ORDER BY KM DESC limit 5;


-- 11)	znajdź klienta z największą liczbą wypożyczeń

SELECT NAME, SURNAME, count(t_rent.CUSTOMER_ID) as rent_count
FROM t_rent 
INNER JOIN t_customer ON t_rent.CUSTOMER_ID=t_customer.CUSTOMER_ID 
group by t_rent.CUSTOMER_ID 
order by rent_count desc
limit 1
;

-- 12)	podaj liczbę wszystkich wypożyczeń w każdym miesiącu, niezależnie od roku. Uwzględnij tylko te, w których były jakieś wypożyczenia

SELECT DATE_FORMAT(STARTING_DATE, '%m') as month, count(RENT_ID) as total
from t_rent
GROUP BY date_format(STARTING_DATE, '%m')
order by month asc;

-- 13)	dla każdego miesiąca podaj średnią liczbę wypożyczeń na klienta

select date_format(STARTING_DATE, '%m') as month, COUNT(*)/COUNT(distinct CUSTOMER_ID) as 'rents per customer'
from t_rent
group by month
order by month asc
;
-- 14)	znajdź klientów, którzy wypożyczyli największą liczbę różnych samochodów

select t_rent.CUSTOMER_ID as id, NAME, SURNAME, COUNT(distinct t_rent.CAR_ID) as unique_cars
from t_rent 
inner join t_customer ON t_rent.CUSTOMER_ID=t_customer.CUSTOMER_ID 
group by id
order by unique_cars desc
limit 5;

-- 15)	znajdź marki samochodów najczęściej wypożyczanych przez klientów

SELECT  BRAND, count(BRAND) as rent_count
from t_rent
inner join t_car on t_rent.CAR_ID = t_car.CAR_ID
group by BRAND
order by rent_count desc;

-- 16)	znajdź klientów, którzy zapłacili najwięcej za wypożyczenia w bieżącym roku. Wykorzystaj widok

Select NAME, SURNAME, sum(costs) as total_costs
from v_clientrent
where YEAR(STARTING_DATE) = YEAR(curdate())
group by CUSTOMER_ID
order by total_costs desc
limit 5
;

-- 17)	znajdź klientów, którzy wypożyczyli samochód marki X w dacie między Y a Z

-- X=Ford
-- Y=2018-03-24
-- Z=2018-05-06

SELECT t_customer.CUSTOMER_ID, NAME, SURNAME, BRAND, STARTING_DATE
from t_customer
inner join t_rent on t_rent.CUSTOMER_ID=t_customer.CUSTOMER_ID
inner join t_car on t_car.CAR_ID=t_rent.CAR_ID
where STARTING_DATE between DATE('2018-01-24') and date('2018-06-06')
and BRAND='FORD';

-- 18)	znajdź klientów, którzy mieli choć przez chwilę wypożyczony samochód marki X w dacie między Y a Z. Weź pod uwagę różne możliwości nakładania się terminów

-- X=Ford
-- Y=2017-10-01
-- Z=2018-05-01

Select t_rent.CUSTOMER_ID,NAME, SURNAME, BRAND
from t_rent
inner join t_car on t_car.CAR_ID=t_rent.CAR_ID
inner join t_customer on t_customer.CUSTOMER_ID=t_rent.CUSTOMER_ID
WHERE STARTING_DATE <= '2018-05-01' and FINISH_DATE >= '2017-10-01' and BRAND = 'FORD'
group by CUSTOMER_ID;

-- grupuje po ID, ponieważ niektórzy klienci wielokrotnie wyporzyczyli daną markę w tym okresie czasu, a krotność wyporzyczeń jest mi niepotrzebna :)

-- 19)	znajdź klienta, który najczęściej wypożycza i oddaje samochody w innych miejsc

Select t_customer.CUSTOMER_ID as id, NAME, SURNAME, COUNT(t_rent.CUSTOMER_ID) as diff_places_count
from
t_rent
inner join t_customer on t_customer.CUSTOMER_ID=t_rent.CUSTOMER_ID
where COMPANY_ID_START != COMPANY_ID_FINISH
group by id
order by diff_places_count desc
limit 1
;

-- 20)	znajdź domenę, w której klienci najczęściej posiadają adres e-mail (np. gmail.com albo wp.pl)
SELECT substring_index(E_MAIL, '@', -1) as domain, COUNT(*) AS email_count
FROM t_customer
GROUP BY domain
ORDER BY email_count DESC
limit 1;


-- 21)	znajdź samochody, które mają co najmniej 2 opiekunów

Select CAR_ID , count(distinct EMPLOYEE_ID) keeper_count
from t_service
group by CAR_ID
having count(distinct EMPLOYEE_ID) >=2 
order by keeper_count desc; 

-- 22)	znajdź pracowników, którzy nie opiekują się żadnym samochodem

SELECT NAME, SURNAME
from t_employee
where EMPLOYEE_ID NOT IN (
select distinct EMPLOYEE_ID
from t_service   
);


-- 23)	zaktualizuj kolor samochodu X

Select BRAND, MODEL, COLOR
from t_car
where CAR_ID=10;

UPDATE t_car
SET COLOR = 'Brown'
where CAR_ID = 10;

Select BRAND, MODEL, COLOR
from t_car
where COLOR = 'Brown';

