-- -- -------------------------------------------------------------------------------
-- -- Zadanie 1
-- -- -------------------------------------------------------------------------------

-- -- -------------------------------------------------------------------------------
-- Section: setting sql_mode
-- -- -------------------------------------------------------------------------------
-- Key settings:
-- ONLY_FULL_GROUP_BY = gwarantuje swiadome deklarowanie sekcji GROUP BY
-- STRICT_ALL_TABLES = gwarantuje, że wstawicie odpowiednie typy/długości danych w odpowiednie miejsca
--		DB automatycznie nie będzie konwertował typów ani nie ucinał długości znaków.
--		Czyli nie bedzie mozliwe wstawienie stringa '10/24' do pola INT(10) ani stringa
--		o dlugosci 100 znakow w pole VARCHAR(10). Przy wlaczonym STRICT_ALL_TABLES pojawi sie Error
--		a nie Warning.
-- SQL Modes: https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html
-- -- -------------------------------------------------------------------------------

SET sql_mode='ONLY_FULL_GROUP_BY,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO';

-- -- -------------------------------------------------------------------------------
-- Section: DROP DATABASE lub DROP Tables
-- -- -------------------------------------------------------------------------------
-- Tutaj usuwamy całą bazę przed jej zadeklarowaniem. To pozwoli Wam łatwo resetować
-- bazę danych w trakcie testów.
-- -- -------------------------------------------------------------------------------

DROP DATABASE IF EXISTS jsk_v7_bartosz_passon;

create database jsk_v7_bartosz_passon;
use jsk_v7_bartosz_passon;
-- -- -------------------------------------------------------------------------------
-- Section: USE
-- Zamien 'jsk_v7_jan_kowalski' na poprawna nazwe Twojej bazy danych
-- Format nazwy DB: jsk_v7_[imie]_[nazwisko]
-- -- -------------------------------------------------------------------------------

-- -- -------------------------------------------------------------------------------
-- Section: CREATE
-- -- -------------------------------------------------------------------------------
-- Tutaj tworzymy nasze tabele bez kluczy obcych. Definiujemt_customert_customery tylko i wyłącznie tabele.
-- W sekcji niżej należy pododawać relacje między tabelami. To daje większą przejrzystość.
-- -- -------------------------------------------------------------------------------
CREATE TABLE `jsk_v7_bartosz_passon`.`t_customer` (
  `CUSTOMER_ID` INT(10) NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NOT NULL,
  `SURNAME` VARCHAR(45) NOT NULL,
  `E_MAIL` VARCHAR(45) NOT NULL,
  `PHONE_NO` VARCHAR(45) NOT NULL,
  `PERSONAL_NO` VARCHAR(45) NOT NULL,
  `CREDIT_CARD_NO` VARCHAR(45) NOT NULL,
  `ADRESS` INT(10) NOT NULL,
  PRIMARY KEY (`CUSTOMER_ID`));
  
  CREATE TABLE `jsk_v7_bartosz_passon`.`t_car` (
  `CAR_ID` int(10) NOT NULL AUTO_INCREMENT,
  `TYPE` enum('SEDAN','HATCHBACK','COMBI','SUV','CABRIO') NOT NULL,
  `BRAND` varchar(45) NOT NULL,
  `MODEL` varchar(45) NOT NULL,
  `ENGINE` float NOT NULL,
  `YEAR` year(4) NOT NULL,
  `HP` int(11) NOT NULL,
  `KM` int(11) NOT NULL,
  `COLOR` varchar(45) NOT NULL,
  PRIMARY KEY (`CAR_ID`));
  

CREATE TABLE `jsk_v7_bartosz_passon`.`t_service` (
  `SERVICE_ID` int(10)  NOT NULL AUTO_INCREMENT,
  `CAR_ID` int(10) NOT NULL,
  `EMPLOYEE_ID` int(10) NOT NULL,
  PRIMARY KEY (`SERVICE_ID`));
  
  
  CREATE TABLE `jsk_v7_bartosz_passon`.`t_adress` (
  `ADRESS` int(10)  NOT NULL AUTO_INCREMENT,
  `STREET` varchar(45) NOT NULL,
  `HOUSE_NO` varchar(10) NOT NULL,
  `CITY` varchar(45) NOT NULL,
  `POST_CODE` varchar(10) NOT NULL,
  PRIMARY KEY (`ADRESS`));
 

  
CREATE TABLE `jsk_v7_bartosz_passon`.`t_company` (
  `COMPANY_ID` int(10) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(45) NOT NULL,
  `PHONE_NO` varchar(45) NOT NULL,
  `ADRESS` INT(10) NOT NULL,
  PRIMARY KEY (`COMPANY_ID`));
  
  CREATE TABLE `jsk_v7_bartosz_passon`.`t_employee` (
  `EMPLOYEE_ID` INT(10)  NOT NULL AUTO_INCREMENT,
  `COMPANY_ID` INT(10) NOT NULL,
  `PERSONAL_NO` VARCHAR(45) NOT NULL,
  `NAME` VARCHAR(45) NOT NULL,
  `SURNAME` VARCHAR(45) NOT NULL,
  `BIRTH_DATE` DATE NOT NULL,
  `POSITION` VARCHAR(45) NOT NULL,
  `ADRESS` INT(10) NOT NULL,
  PRIMARY KEY (`EMPLOYEE_ID`));
  
  CREATE TABLE `jsk_v7_bartosz_passon`.`t_rent` (
  `RENT_ID` INT(10) NOT NULL AUTO_INCREMENT,
  `CAR_ID` INT(10) NOT NULL,
  `CUSTOMER_ID` INT(10) NOT NULL,
  `STARTING_DATE` DATE NOT NULL,
  `FINISH_DATE` DATE NOT NULL,
  `COMPANY_ID_START` INT NOT NULL,
  `COMPANY_ID_FINISH` INT NOT NULL,
  `RENT_COST` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`RENT_ID`));


-- -- -------------------------------------------------------------------------------
-- Section: ALTER TABLE
-- -- -------------------------------------------------------------------------------
-- Tutaj dodajemy klucze obce oraz ewentualne zmiany w tabelach.
-- -- -------------------------------------------------------------------------------
ALTER TABLE `jsk_v7_bartosz_passon`.`t_service` 
ADD INDEX `SERVICE_CAR_FK_idx` (`CAR_ID` ASC) VISIBLE,
ADD INDEX `SERVICE_EMPLOYEE_FK_idx` (`EMPLOYEE_ID` ASC) VISIBLE;
;
ALTER TABLE `jsk_v7_bartosz_passon`.`t_service` 
ADD CONSTRAINT `SERVICE_CAR_FK`
  FOREIGN KEY (`CAR_ID`)
  REFERENCES `jsk_v7_bartosz_passon`.`t_car` (`CAR_ID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `SERVICE_EMPLOYEE_FK`
  FOREIGN KEY (`EMPLOYEE_ID`)
  REFERENCES `jsk_v7_bartosz_passon`.`t_employee` (`EMPLOYEE_ID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE `jsk_v7_bartosz_passon`.`t_rent` 
ADD INDEX `RENT_CAR_FK_idx` (`CAR_ID` ASC) VISIBLE,
ADD INDEX `RENT_CUSTOMER_FK_idx` (`CUSTOMER_ID` ASC) VISIBLE,
ADD INDEX `RENT_COMPANY_START_FK_idx` (`COMPANY_ID_START` ASC) VISIBLE,
ADD INDEX `RENT_COMPANY_FINISH_FK_idx` (`COMPANY_ID_FINISH` ASC) VISIBLE;
;
ALTER TABLE `jsk_v7_bartosz_passon`.`t_rent` 
ADD CONSTRAINT `RENT_CAR_FK`
  FOREIGN KEY (`CAR_ID`)
  REFERENCES `jsk_v7_bartosz_passon`.`t_car` (`CAR_ID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `RENT_CUSTOMER_FK`
  FOREIGN KEY (`CUSTOMER_ID`)
  REFERENCES `jsk_v7_bartosz_passon`.`t_customer` (`CUSTOMER_ID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `RENT_COMPANY_START_FK`
  FOREIGN KEY (`COMPANY_ID_START`)
  REFERENCES `jsk_v7_bartosz_passon`.`t_company` (`COMPANY_ID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `RENT_COMPANY_FINISH_FK`
  FOREIGN KEY (`COMPANY_ID_FINISH`)
  REFERENCES `jsk_v7_bartosz_passon`.`t_company` (`COMPANY_ID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `jsk_v7_bartosz_passon`.`t_employee` 
ADD INDEX `EMPLOYEE_COMPANY_FK_idx` (`COMPANY_ID` ASC) VISIBLE;
;
ALTER TABLE `jsk_v7_bartosz_passon`.`t_employee` 
ADD CONSTRAINT `EMPLOYEE_COMPANY_FK`
  FOREIGN KEY (`COMPANY_ID`)
  REFERENCES `jsk_v7_bartosz_passon`.`t_company` (`COMPANY_ID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE `jsk_v7_bartosz_passon`.`t_company` 
ADD INDEX `COMPANY_ADRESS_FK_idx` (`ADRESS` ASC) VISIBLE;
;
ALTER TABLE `jsk_v7_bartosz_passon`.`t_company` 
ADD CONSTRAINT `COMPANY_ADRESS_FK`
  FOREIGN KEY (`ADRESS`)
  REFERENCES `jsk_v7_bartosz_passon`.`t_adress` (`ADRESS`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `jsk_v7_bartosz_passon`.`t_customer` 
ADD INDEX `CUSTOMER_ADRESS_FK_idx` (`ADRESS` ASC) VISIBLE;
;
ALTER TABLE `jsk_v7_bartosz_passon`.`t_customer` 
ADD CONSTRAINT `CUSTOMER_ADRESS_FK`
  FOREIGN KEY (`ADRESS`)
  REFERENCES `jsk_v7_bartosz_passon`.`t_adress` (`ADRESS`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `jsk_v7_bartosz_passon`.`t_employee` 
ADD INDEX `EMPLOYEE_ADRESS_FK_idx` (`ADRESS` ASC) VISIBLE;
;
ALTER TABLE `jsk_v7_bartosz_passon`.`t_employee` 
ADD CONSTRAINT `EMPLOYEE_ADRESS_FK`
  FOREIGN KEY (`ADRESS`)
  REFERENCES `jsk_v7_bartosz_passon`.`t_adress` (`ADRESS`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


  



