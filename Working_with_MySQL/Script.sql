-- В ранее подключенном MySQL создать базу данных с названием "Human Friends
DROP DATABASE IF EXISTS human_friends;
CREATE DATABASE human_friends;

-- Создать таблицы, соответствующие иерархии из вашей диаграммы классов.

USE human_friends;

CREATE TABLE animals (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	class_name VARCHAR(20)
);

INSERT INTO
	animals (class_name)
VALUES 
	('Pack_animals'),
	('Pets');  

CREATE TABLE pack_animals (
	id INT AUTO_INCREMENT PRIMARY KEY,
    subclass_name VARCHAR (20),
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO 
	pack_animals (subclass_name, class_id)
VALUES
	('Horses', 1),
	('Donkeys', 1),  
	('Camels', 1); 
    
CREATE TABLE pets (
	id INT AUTO_INCREMENT PRIMARY KEY,
    subclass_name VARCHAR (20),
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO 
	pets (subclass_name, class_id)
VALUES 
	('Cats', 2),
	('Dogs', 2),  
	('Hamsters', 2); 

CREATE TABLE cats (       
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(20), 
    type_id INT, 
    birthday DATE,
    commands VARCHAR(50),
    Foreign KEY (type_id) REFERENCES pets (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE dogs (       
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(20), 
    type_id INT, 
    birthday DATE,
    commands VARCHAR(50),
    Foreign KEY (type_id) REFERENCES pets (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE hamsters (       
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(20), 
    type_id INT, 
    birthday DATE,
    commands VARCHAR(50),
    Foreign KEY (type_id) REFERENCES pets (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE horses (       
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(20), 
    type_id INT, 
    birthday DATE,
    commands VARCHAR(50),
    Foreign KEY (type_id) REFERENCES pack_animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE donkeys (       
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(20), 
    type_id INT, 
    birthday DATE,
    commands VARCHAR(50),
    Foreign KEY (type_id) REFERENCES pack_animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE camels (       
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(20), 
    type_id INT, 
    birthday DATE,
    commands VARCHAR(50),
    Foreign KEY (type_id) REFERENCES pack_animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Заполнить таблицы данными о животных, их командах и датами рождения.

INSERT INTO 
	cats (name, type_id, birthday, commands)
VALUES 
	('Whiskers', 1, '2019-05-15', 'Sit, Pounce'),
	('Smudge', 1, '2020-02-20', 'Sit, Pounce, Scratch'),  
	('Oliver', 1, '2020-06-30', 'Meow, Scratch, Jump'); 

INSERT INTO 
	dogs (name, type_id, birthday, commands)
VALUES 
	('Fido', 2, '2020-01-01', 'Sit, Stay, Fetch'),
	('Buddy', 2, '2018-12-10', 'Sit, Paw, Bark'),  
	('Bella', 2, '2019-11-11', 'Sit, Stay, Roll'); 

INSERT INTO 
	hamsters (name, type_id, birthday, commands)
VALUES 
	('Hammy', 3, '2021-03-10', 'Roll, Hide'),
	('Peanut', 3, '2021-08-01', 'Roll, Spin'); 

INSERT INTO 
	horses (name, type_id, birthday, commands)
VALUES 
	('Thunder', 1, '2015-07-21', 'Trot, Canter, Gallop'),
	('Storm', 1, '2014-05-05', 'Trot, Canter'),  
	('Blaze', 1, '2016-02-29', 'Trot, Jump, Gallop'); 

INSERT INTO 
	donkeys (name, type_id, birthday, commands)
VALUES 
	('Eeyore', 2, '2017-09-18', 'Walk, Carry Load, Bray'), 
	('Burro', 2, '2019-01-23', 'Walk, Bray, Kick'); 

INSERT INTO 
	camels (name, type_id, birthday, commands)
VALUES 
	('Sandy', 3, '2016-11-03', 'Walk, Carry Load'),
	('Dune', 3, '2018-12-12', 'Walk, Sit'), 
	('Sahara', 3, '2015-08-14', 'Walk, Run'); 

-- Удалить записи о верблюдах и объединить таблицы лошадей и ослов.

DELETE FROM camels;

CREATE TABLE horses_and_donkeys 
SELECT * FROM horses
	UNION 
SELECT * FROM donkeys;

-- Создать новую таблицу для животных в возрасте от 1 до 3 лет и вычислить их возраст с точностью до месяца.

DROP TABLE IF EXISTS temp_animals;
CREATE TEMPORARY TABLE temp_animals AS
SELECT * FROM cats
UNION
SELECT * FROM dogs
UNION
SELECT * FROM hamsters
UNION
SELECT * FROM horses
UNION
SELECT * FROM donkeys
UNION
SELECT * FROM camels;

DROP TABLE IF EXISTS young_animals;
CREATE TABLE young_animals
SELECT
	name, type_id, birthday, commands, TIMESTAMPDIFF(MONTH, birthday, CURDATE()) AS age_in_month
FROM 
	temp_animals
WHERE birthday BETWEEN ADDDATE(CURDATE(), INTERVAL -3 YEAR) AND ADDDATE(CURDATE(), INTERVAL -1 YEAR);

-- Объединить все созданные таблицы в одну, сохраняя информацию о принадлежности к исходным таблицам.

DROP TABLE IF EXISTS all_animals;
CREATE TABLE all_animals

SELECT 
	dg.name,
	p.subclass_name, 
	dg.birthday, 
	dg.commands,
	a.class_name
FROM dogs dg
LEFT JOIN pets p ON p.id = dg.type_id
LEFT JOIN animals a ON a.id = p.class_id
UNION
SELECT 
	ct.name,
	p.subclass_name, 
	ct.birthday, 
	ct.commands,
	a.class_name
FROM cats ct
LEFT JOIN pets p ON p.id = ct.type_id
LEFT JOIN animals a ON a.id = p.class_id
UNION
SELECT 
	hm.name,
	p.subclass_name, 
	hm.birthday, 
	hm.commands,
	a.class_name
FROM hamsters hm
LEFT JOIN pets p ON p.id = hm.type_id
LEFT JOIN animals a ON a.id = p.class_id
UNION
SELECT 
	hr.name,
	pa.subclass_name, 
	hr.birthday, 
	hr.commands,
	a.class_name
FROM horses hr
LEFT JOIN pack_animals pa ON pa.id = hr.type_id
LEFT JOIN animals a ON a.id = pa.class_id
UNION
SELECT 
	dk.name,
	pa.subclass_name, 
	dk.birthday, 
	dk.commands,
	a.class_name
FROM donkeys dk
LEFT JOIN pack_animals pa ON pa.id = dk.type_id
LEFT JOIN animals a ON a.id = pa.class_id
UNION
SELECT 
	cm.name,
	pa.subclass_name, 
	cm.birthday, 
	cm.commands,
	a.class_name
FROM camels cm
LEFT JOIN pack_animals pa ON pa.id = cm.type_id
LEFT JOIN animals a ON a.id = pa.class_id
























