CREATE DATABASE animals1;
USE animals1;

CREATE TABLE cat (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date DATE);

CREATE TABLE dog (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date DATE);

CREATE TABLE hamster (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date DATE);

CREATE TABLE horse (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date DATE);

CREATE TABLE camel (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date DATE);

CREATE TABLE donkey (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date DATE);

INSERT INTO cat (animal_name,commands, date) VALUES 
	('cata', 'ест', '23-01-10'),
	('ivan', 'спит', '2022-02-12');
   
INSERT INTO dog (animal_name,commands, date) VALUES 
	('bridg', 'ходит', '2024-02-01'),
	('liston', 'лежит', '2025-05-05');
    
INSERT INTO hamster (animal_name,commands, date) VALUES 
	('ivan', 'грызет', '2024-02-26'),
	('artem', 'уплетает', '2025-12-15');
    
INSERT INTO horse (animal_name,commands, date) VALUES 
	('oleg', 'скачает', '2004-02-28'),
	('post', 'возит', '2015-01-30');
    
INSERT INTO camel (animal_name,commands, date) VALUES 
	('igor', 'употребляет', '2020-12-31'),
	('poat', 'пьет', '2021-01-30');
    
INSERT INTO donkey (animal_name,commands, date) VALUES 
	('red', 'ест', '2015-09-26'),
	('yelloe', 'прыгает', '2016-07-17');
    
TRUNCATE camel;

INSERT INTO horse (animal_name, commands, date)
SELECT animal_name, commands, date
FROM donkey;

DROP TABLE donkey;

RENAME TABLE horse TO horse_and_donkey;
--------------------------------------------------------------
CREATE TABLE smoll_animal (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date DATE,
    age TEXT
);


DELIMITER $$
CREATE FUNCTION age_animal (date_s DATE)
RETURNS TEXT
DETERMINISTIC
BEGIN
    DECLARE res TEXT DEFAULT '';
	SET res = CONCAT(
            TIMESTAMPDIFF(YEAR, date_s, CURDATE()),
            ' years ',
            TIMESTAMPDIFF(MONTH, date_s, CURDATE()) % 12,
            ' month'
        );
	RETURN res;
END $$

-----------------------------------------------------------------------
INSERT INTO smoll_animal (animal_name, commands, date, age)
SELECT animal_name, commands, date, age_animal(date)
FROM cat
WHERE TIMESTAMPDIFF(YEAR, date, CURDATE()) BETWEEN 1 AND 3
UNION ALL
SELECT animal_name, commands, date, age_animal(date)
FROM dog
WHERE TIMESTAMPDIFF(YEAR, date, CURDATE()) BETWEEN 1 AND 3
UNION ALL
SELECT animal_name, commands, date, age_animal(date)
FROM hamster
WHERE TIMESTAMPDIFF(YEAR, date, CURDATE()) BETWEEN 1 AND 3
UNION ALL
SELECT animal_name, commands, date, age_animal(date)
FROM horse_and_donkey
WHERE TIMESTAMPDIFF(YEAR, date, CURDATE()) BETWEEN 1 AND 3;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM cat 
WHERE TIMESTAMPDIFF(YEAR, date, CURDATE()) BETWEEN 1 AND 3;

DELETE FROM dog 
WHERE TIMESTAMPDIFF(YEAR, date, CURDATE()) BETWEEN 1 AND 3;

DELETE FROM hamster 
WHERE TIMESTAMPDIFF(YEAR, date, CURDATE()) BETWEEN 1 AND 3;

DELETE FROM horse_and_donkey 
WHERE TIMESTAMPDIFF(YEAR, date, CURDATE()) BETWEEN 1 AND 3;

CREATE TABLE animals (
	id INT PRIMARY KEY AUTO_INCREMENT,
	animal_name CHAR(30),
    commands TEXT,
    date DATE,
    age TEXT,
    animal_type ENUM('cat','dog','hamster', 'horse_and_donkey', 'smoll_animals') NOT NULL
);

INSERT INTO animals (animal_name, commands, date, age, animal_type)
SELECT animal_name, commands, date, age_animal(date), 'cat'
FROM cat;

INSERT INTO animals (animal_name, commands, date, age, animal_type)
SELECT animal_name, commands, date, age_animal(date), 'dog'
FROM dog;

INSERT INTO animals (animal_name, commands, date, age, animal_type)
SELECT animal_name, commands, date, age_animal(date), 'hamster'
FROM hamster;

INSERT INTO animals (animal_name, commands, date, age, animal_type)
SELECT animal_name, commands, date, age_animal(date), 'horse_and_donkey'
FROM horse_and_donkey;

INSERT INTO animals (animal_name, commands, date, age, animal_type)
SELECT animal_name, commands, date, age_animal(date), 'smoll_animals'
FROM smoll_animal;


