CREATE DATABASE formation;

SHOW DATABASES;

USE formation;

SHOW TABLES;

CREATE TABLE contact (
	id INT PRIMARY KEY AUTO_INCREMENT,
	lastname VARCHAR(100) NOT NULL,
	firstname VARCHAR(100),
	phone_number VARCHAR(30),
	email VARCHAR(255) UNIQUE
);

DROP TABLE contact;

DESCRIBE contact;

ALTER TABLE contact
	ADD COLUMN city VARCHAR(100),
	MODIFY phone_number VARCHAR(20) NOT NULL;
    
   
INSERT INTO contact (lastname, firstname, phone_number, city)
VALUES ('Aldaitz', 'Thomas', '051053131', 'Lyon');

INSERT INTO contact (lastname, firstname, phone_number, city)
VALUES ('Retest', 'Jean', '051053131', 'Nantes'),
		('Test', 'Robert', '4946435453', 'Paris')
;


SELECT * FROM contact;

UPDATE contact
SET phone_number = '064551314'
WHERE id = 2
;


UPDATE contact
SET city = 'Paris', email = 'taldaitz@dawan.fr'
WHERE id = 1
;



SELECT *
FROM contact
WHERE firstname = '%a'
;

/*[14:14] RAMBERT ANAIS*/
CREATE TABLE animal (
	id INT PRIMARY KEY auto_increment,
	name VARCHAR(200)not null,
	species VARCHAR(150)not null,
	date_of_birth DATE not null,
	country VARCHAR(15),
	arrival_date DATE not null,
	box_number TINYINT not null,
	section VARCHAR(30) default "foret" not null,
	is_vaccinated BOOLEAN not null
);

DROP TABLE animal;

/*Louis*/
CREATE TABLE animal (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    species VARCHAR(150) NOT NULL,
    date_of_birth DATE NOT NULL,
    country VARCHAR(100) NULL,
    arrival_date DATE NOT NULL,
    box_number INT NULL,
    section VARCHAR(10) DEFAULT 'Foret',
    is_vaccinated BOOLEAN
);

/*Fabien*/
create table animal (
	id int primary key auto_increment,
	name varchar(200) not null,
	species varchar(150) not null,
	date_of_birth date not null,
	country varchar(100)null,
	arrival_date date not null,
	box_number tinyint not null,
	section varchar (100) default "foret",
	is_vaccinated boolean
);

/*Charles*/
CREATE TABLE animal(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(200) NOT NULL,
	species VARCHAR(150),
	date_of_birth DATE NOT NULL,
	country VARCHAR(100) NULL,
	arrival_date DATE NOT NULL,
	box_number TINYINT NOT NULL,
	section VARCHAR(20) DEFAULT "Foret",
	is_vaccinated BOOLEAN NOT NULL
);


DESCRIBE animal;


CREATE TABLE animal(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(200) NOT NULL,
species VARCHAR(150),
date_of_birth DATE NOT NULL,
country VARCHAR(100) NULL,
arrival_date DATE NOT NULL,
box_number TINYINT NOT NULL,
section VARCHAR(100) DEFAULT "foret",
is_vaccinated BOOLEAN NOT NULL
);


ALTER TABLE animal
ADD COLUMN notes TEXT NULL,
DROP COLUMN arrival_date,
MODIFY species VARCHAR(150) NULL;

DESCRIBE animal;

USE formation;

DELETE FROM animal;

INSERT INTO animal (name, date_of_birth, section, is_vaccinated)
VALUES ('singer','2022-02-14','montagne', true),
		   ('sneakers','2022-11-11','desert',false),
           ('birdy','2002-04-04','plaine', true),
           ('fishboy','2023-12-01','mer',false)
;

INSERT INTO animal (name, date_of_birth, box_number, section, is_vaccinated)
VALUES ('babar', '2015-02-03','1','foret',false),
		('jojo','2016-01-02','3','montagne',true),
        ('gigi','2018-01-04','4','mer',false),
        ('gege','2019-03-03','5','desert',true)
        ;
        
SELECT * FROM animal;


SELECT * FROM animal
WHERE date_of_birth BETWEEN '2024-01-01' AND '2024-03-01';

SELECT * FROM contact
ORDER BY city, firstname DESC
;

/*1 - singer -> section : foret*/

UPDATE animal
SET section = "montagne"
WHERE name = 'singer';

/*2 - fishboy -> date de naissance : 18/02/2024*/

UPDATE animal
SET date_of_birth = '2024-02-18'
WHERE name = 'fishboy';

/*3 - tous les animaux marins ont été vaccinés*/

UPDATE animal
SET is_vaccinated = true
WHERE section = 'mer';

/*4 - Les animaux de montagne sont des 
oiseaux (espèces) sauf 'jojo'*/

UPDATE animal
SET species = 'oiseau'
WHERE section = 'montagne'
AND name <> 'jojo';


SELECT * FROM animal;

DELETE FROM animal
WHERE is_vaccinated = false;

/*-> Le nom, prénom et email des clients dont le prénom est "Julien"*/
SELECT customer_lastname,
		customer_firstname,
		customer_email
FROM full_order
WHERE customer_firstname = 'Julien';

/*-> Le nom, prénom et email des clients dont l'email 
	termine par "@gmail.com"*/
    
SELECT customer_lastname,
		customer_firstname,
		customer_email
FROM full_order
WHERE customer_email LIKE '%@gmail.com';

/*-> toutes les commandes  non payées*/

SELECT * 
FROM full_order
WHERE is_paid = false;

/*-> toutes les commandes  payées mais non livré*/

SELECT * 
FROM full_order
WHERE is_paid = true
AND shipment_date IS NULL
;

/*-> toutes les commandes  livré hors de France*/

SELECT * 
FROM full_order
WHERE shipment_country <> 'France'
;


/*-> toutes les commandes au montant de plus 8000€ ordonnées du montant le plus grand au plus petit*/
SELECT * 
FROM full_order
WHERE amount > 8000
ORDER BY amount DESC;

/*-> La commande au montant le plus élevé (une seule)*/
SELECT * 
FROM full_order
ORDER BY amount DESC
LIMIT 1;

/*-> toutes les commandes réglé en Cash en 2022 livré en France dont le montant est inférieur à 5000 €*/
SELECT * 
FROM full_order
WHERE payment_type = 'Cash'
AND shipment_country = 'France'
AND payment_date BETWEEN '2022-01-01' AND '2022-12-31'
AND amount < 5000;

/*-> toutes les commandes payés par carte ou payé aprés le 15/10/2021*/
SELECT * 
FROM full_order
WHERE payment_type = 'Credit Card'
OR payment_date > '2021-10-15';

/*-> les 3 dernières commandes envoyées en France*/
SELECT * 
FROM full_order
WHERE shipment_country = 'France'
ORDER BY shipment_date DESC
LIMIT 3;


/*-> les 10 commandes les plus élevés passé sur l'année 2021*/
SELECT date, amount 
FROM full_order
WHERE YEAR(date) = 2021
ORDER BY amount DESC
LIMIT 10;



DESCRIBE full_order;


/*-> la somme des commandes non payés*/
SELECT ROUND(SUM(amount), 2) AS NonPayées
FROM full_order
WHERE is_paid = false;

/*-> la moyenne des montants des commandes payés en cash*/
SELECT ROUND(AVG(amount), 2) AS PayéesEnCash
FROM full_order
WHERE payment_type = 'Cash';

/*-> le nombre de client dont le nom est "Laporte"*/

SELECT COUNT(*)
FROM full_order
WHERE customer_lastname = 'Laporte'
;

/*-> Le nombre de jour Maximum entre la date de payment et la date de livraison 
-> DATEDIFF()*/
SELECT MAX(ABS(DATEDIFF(shipment_date, payment_date)))
FROM full_order
;


/*-> Le délai moyen (en jour) de réglement d'une commande*/
SELECT ROUND(AVG(DATEDIFF(payment_date, date)), 2) AS delaiMoyen
FROM full_order
;


/*-> le nombre de commande payés en chèque sur 2021*/
SELECT COUNT(*)
FROM full_order
WHERE payment_type = 'Check'
AND YEAR(date) = 2021;


SELECT shipment_country,  ROUND(SUM(amount), 2) AS CA
FROM full_order
WHERE shipment_country IS NOT NULL
GROUP BY shipment_country
	HAVING CA > 10000
ORDER BY shipment_country
;

SELECT shipment_country, amount
FROM full_order
WHERE shipment_country IS NOT NULL
ORDER BY shipment_country;

/*-> Le montant total des commandes par type de paiement*/
SELECT payment_type, ROUND(SUM(amount), 2) AS TotalAmount
FROM full_order
WHERE is_paid = true
GROUP BY payment_type
;

/*-> La moyenne des montants des commandes par Pays*/

SELECT shipment_country, ROUND(AVG(amount), 2) AS MoyennePays
FROM full_order
WHERE shipment_country IS NOT NULL
GROUP BY shipment_country
ORDER BY shipment_country
;

/*-> Par année la somme des commandes*/

SELECT YEAR(date) AS Année, ROUND(SUM(amount), 2)
FROM full_order
GROUP BY Année
ORDER BY Année
;

/*-> Liste des clients (nom, prénom) qui ont au moins deux commandes*/

SELECT customer_lastname, customer_firstname, COUNT(*) AS nbCommande
FROM full_order
GROUP BY customer_lastname, customer_firstname
	HAVING nbCommande >= 2
ORDER BY customer_lastname, customer_firstname
;


SELECT customer_lastname, customer_firstname
FROM full_order
ORDER BY customer_lastname, customer_firstname
;


SELECT * FROM animal;

CREATE TABLE section (
	id INT PRIMARY KEY AUTO_INCREMENT,
    label VARCHAR(100) NOT NULL
);

INSERT INTO section (label)
VALUES 
	('desert'),
    ('montagne'),
    ('mer'),
    ('foret')
;




ALTER TABLE animal
	ADD COLUMN section_id INT NOT NULL;
    
ALTER TABLE animal
	DROP COLUMN section;
    
    
SELECT animal.name, section.label
FROM animal
	JOIN section ON animal.section_id = section.id
;

SELECT * FROM section;
SELECT * FROM animal;

SELECT an.name, se.label
FROM animal an
	RIGHT JOIN section se ON an.section_id = se.id
; 



SELECT cu.lastname, cu.firstname, COUNT(*)
FROM customer cu
	JOIN bill bi ON bi.customer_id = cu.id
GROUP BY cu.lastname, cu.firstname
;


select *
from product join category 
	ON product.category_id = category.id;

SELECT * FROM product;
SELECT * FROM category;


USE billings;

/*-> tous les produits avec leur nom et le label de leur 
catégorie*/
select product.name, category.label
from product 
	join category ON product.category_id = category.id;

/*-> Pour chaque client (nom, prénom) remonter le nombre de 
facture associé*/

SELECT cu.lastname, cu.firstname, COUNT(bi.id) AS nbBill
FROM customer cu
	JOIN bill bi ON bi.customer_id = cu.id
GROUP BY cu.lastname, cu.firstname
;

/*-> Pour chaque catégorie la moyenne des prix unitaires 
de produits associés*/

SELECT ca.label, ROUND(AVG(pr.unit_price), 2) AS moyenne_prix
FROM category ca
	JOIN product pr ON pr.category_id = ca.id
GROUP BY ca.label
;



/*-> Pour Chaque produit la quantité commandée depuis 
le 01/01/2021*/

SELECT pr.name, SUM(li.quantity) AS total_qte, SUM(li.quantity * pr.unit_price)
FROM product pr
	JOIN line_item li ON li.product_id = pr.id
    JOIN bill bi ON li.bill_id = bi.id
WHERE bi.date >= '2021-01-01'
GROUP BY pr.name
ORDER BY total_qte DESC
;

/*Révision Mercredi*/
/*
SELECT * (toutes les colonnes) /
		colonne AS alias
FROM table1
	 JOIN table2 ON table1.table2_id = table2.id
     JOIN table3 ON table3.id = table2.table3_id
WHERE condition => applique un filtre sur les tables du FROM
	AND is_paid = true
    OR ... YEAR(t2.date) > 2020
GROUP BY colonne1 , colonne2
	HAVING condition => sur un resultat d'aggrégat
ORDER BY colonne1 ASC, colonne2 DESC
LIMIT 10
;
*/

USE Formation;

SELECT * FROM animal;
SELECT * FROM section;



SELECT * 
FROM animal, section
WHERE animal.section_id = section.id
;


SELECT *
FROM formation.animal an
	JOIN formation.section se ON an.section_id = se.id
    JOIN billings.bill bi ON bi.customer_id = an.id
;
    
    
ALTER TABLE animal
ADD CONSTRAINT FK_Animal_Section
FOREIGN KEY animal(section_id)
REFERENCES section(id)
;

DELETE FROM section WHERE id = 4;
    


/*-> La liste des Facture (ref) qui ont plus de 2 produits 
différends commandé*/
SELECT bi.ref, COUNT(li.product_id) AS nbProduct
FROM bill bi
	JOIN line_item li ON li.bill_id = bi.id
GROUP BY bi.ref
	HAVING nbProduct > 2
;


/*-> Pour chaque Facture afficher le montant total*/
SELECT bi.ref, SUM(li.quantity), AVG(pr.unit_price), SUM(li.quantity * pr.unit_price), COUNT(*)
FROM bill bi
	JOIN line_item li ON li.bill_id = bi.id
    JOIN product pr ON li.product_id = pr.id
WHERE bi.ref = '298786724'
GROUP BY bi.ref
;

/*-> Pour chaque client compter le nombre de produit 
différents qu'il a commandé*/

SELECT cu.lastname, cu.firstname, COUNT(li.product_id) AS nbProduct
FROM customer cu
	JOIN bill bi ON bi.customer_id = cu.id
    JOIN line_item li ON li.bill_id = bi.id
GROUP BY cu.id
ORDER BY nbProduct DESC
;


USE billings;


CREATE TABLE subscription(
	id INT PRIMARY KEY AUTO_INCREMENT,
    start_date date NOT NULL,
    end_date date NULL,
    customer_id INT NOT NULL
);

SELECT * FROM subscription;
SELECT * FROM customer;


ALTER TABLE subscription
ADD CONSTRAINT FK_customer_subscription
FOREIGN KEY subscription(customer_id)
REFERENCES customer(id);

USE billings;

SELECT bi.ref, SUM(li.quantity * pr.unit_price) AS total_amount
FROM bill bi
	JOIN line_item li ON li.bill_id = bi.id
    JOIN product pr ON li.product_id = pr.id
GROUP BY bi.ref
	HAVING total_amount > (
			SELECT AVG(li.quantity * pr.unit_price)
			FROM bill bi
				JOIN line_item li ON li.bill_id = bi.id
				JOIN product pr ON li.product_id = pr.id
    )
ORDER BY total_amount
;

SELECT AVG(li.quantity * pr.unit_price)
FROM bill bi
	JOIN line_item li ON li.bill_id = bi.id
    JOIN product pr ON li.product_id = pr.id
;

CREATE VIEW view_bill_with_more_than_2_products AS
SELECT bi.ref, COUNT(li.product_id) AS nbProduct
FROM bill bi
	JOIN line_item li ON li.bill_id = bi.id
GROUP BY bi.ref
	HAVING nbProduct > 2
;

SELECT * FROM view_bill_with_more_than_2_products
WHERE nbProduct > 4
;

CREATE VIEW view_bills_with_amount AS
SELECT bi.*, SUM(li.quantity * pr.unit_price) AS total_amount
FROM bill bi
	JOIN line_item li ON li.bill_id = bi.id
    JOIN product pr ON li.product_id = pr.id
GROUP BY bi.id
ORDER BY total_amount
;


SELECT * FROM view_bills_with_amount;

/*-> le nom, prénom et somme des factures des 3 clients qui 
ont passé le plus grand nombre de facture*/
SELECT cu.lastname, 
		cu.firstname, 
        SUM(vbi.total_amount) AS total_billed,
        COUNT(vbi.id) AS nbBill
FROM view_bills_with_amount vbi
	JOIN customer cu ON cu.id = vbi.customer_id
GROUP BY cu.id
ORDER BY nbBill DESC
LIMIT 3
;

/*-> le nom, prénom et (somme des factures) des 3 clients qui ont 
passé les factures les plus chers*/
SELECT cu.lastname, 
		cu.firstname, 
        SUM(vbi.total_amount) AS total_billed,
        MAX(vbi.total_amount) AS maxBill
FROM view_bills_with_amount vbi
	JOIN customer cu ON cu.id = vbi.customer_id
GROUP BY cu.id
ORDER BY maxBill DESC
LIMIT 3
;

/*-> le nom, prénom et somme des factures des 3 clients qui ont  
le total des factures les plus élevés*/
SELECT cu.lastname, 
		cu.firstname, 
        SUM(vbi.total_amount) AS total_billed
FROM view_bills_with_amount vbi
	JOIN customer cu ON cu.id = vbi.customer_id
GROUP BY cu.id
ORDER BY total_billed DESC
LIMIT 3
;


DELIMITER //
CREATE PROCEDURE updateToDefaultQtyAvailable(stock_default INT)
BEGIN
	
    UPDATE ...
    
    UPDATE product
    SET quantity_available = stock_default;
    
END//


SELECT * FROM product;

CALL updateToDefaultQtyAvailable(300);


/*Révisions Mercredi*/

USE billings;

SELECT * FROM product;
SELECT * FROM category;


SELECT ca.label, COUNT(*) AS nbProduct
FROM product pr
	JOIN category ca ON pr.category_id = ca.id
WHERE label LIKE 'c%'
GROUP BY ca.label
	HAVING nbProduct > 150
;

/*Liste des catégories avec la moyenne des pric unitaire de leur produit, ordonné par prix le plus élevé*/

ALTER VIEW view_categories_with_avg_price AS
SELECT category_id, label, ROUND(AVG(unit_price), 2) AS moyennePrix
FROM product pr
	JOIN category ca ON pr.category_id = ca.id
GROUP BY category_id, label
ORDER BY label
;


SELECT * FROM view_categories_with_avg_price;


ALTER TABLE customer
	ADD COLUMN is_vip boolean not null;

DESCRIBE customer;

SELECT * FROM view_bills_with_amount;

SELECT vbi.customer_id
FROM view_bills_with_amount vbi
GROUP BY vbi.customer_id
	HAVING SUM(vbi.total_amount) > 10000
;

DROP PROCEDURE updateVips;
DELIMITER //
CREATE PROCEDURE updateVips(vipAmount float)
BEGIN

	UPDATE customer SET is_vip = false;

	UPDATE customer
	SET is_vip = true
	WHERE id IN (
		SELECT vbi.customer_id
		FROM view_bills_with_amount vbi
		GROUP BY vbi.customer_id
			HAVING SUM(vbi.total_amount) > vipAmount
		)
	;

END//

UPDATE customer SET is_vip = false;

SELECT * FROM customer;

CALL updateVips(20000);

SELECT cu.id, SUM(vbi.total_amount)
FROM view_bills_with_amount vbi
	JOIN customer cu ON cu.id = vbi.customer_id
GROUP BY cu.id WITH ROLLUP
;


SELECT 
	YEAR(date), 
    CASE WHEN is_paid = 1 
			THEN 'Payé' 
            ELSE 'Non payé' END AS Statut, 
    SUM(total_amount)
FROM view_bills_with_amount
GROUP BY YEAR(date), is_paid WITH ROLLUP
;


SELECT cu.lastname, 
		cu.firstname, 
		CASE WHEN is_vip = true THEN 'VIP' ELSE SUM(vbi.total_amount) END AS Statut
FROM customer cu
	JOIN view_bills_with_amount vbi ON vbi.customer_id = cu.id
GROUP BY cu.id;


select  year(bi.date), avg(timestampdiff(year,date_of_birth,now())) as anniv
from category ca
join product pr on pr.category_id = ca.id 
join line_item li on li.product_id = pr.id
join bill bi on li.bill_id = bi.id
join customer cu ON bi.customer_id = cu.id
group by year(bi.date);

/*-> pour chaque catégorie de produit la somme des facture payées*/
SELECT ca.label, SUM(li.quantity * pr.unit_price) AS total_amount
FROM category ca
	JOIN product pr ON pr.category_id = ca.id
    JOIN line_item li ON li.product_id = pr.id
    JOIN bill bi ON li.bill_id = bi.id
WHERE is_paid = true
GROUP BY ca.label
;

/*-> par Année de facture, la moyenne d'age des clients
   => TIMESTAMPDIFF(YEAR, date_of_birth,NOW() ) AS anniversaire
*/
SELECT YEAR(bi.date) AS billYear, AVG(TIMESTAMPDIFF(YEAR, date_of_birth, NOW())) AS moyenne_age
FROM bill bi
	JOIN customer cu ON cu.id = bi.customer_id
GROUP BY billYear
;



/*-> les nom, prénom et num de tel des clients qui ont commandes des produits de 
camping ces deux dernières années*/
SELECT cu.lastname, cu.firstname, cu.phone_number
FROM customer cu
	JOIN bill bi ON bi.customer_id = cu.id
	JOIN line_item li ON li.bill_id = bi.id
	JOIN product pr ON li.product_id = pr.id
    JOIN category ca ON ca.id = pr.category_id
WHERE ca.label = 'Camping'
AND bi.date > ADDDATE(NOW(), INTERVAL -2 YEAR)
GROUP BY cu.id
ORDER BY cu.lastname, cu.firstname
;

/*-> La moyenne d'age des consomateurs pour chaque catégorie de produit*/

SELECT ca.label, ROUND(AVG(TIMESTAMPDIFF(YEAR, date_of_birth, NOW())))
FROM customer cu
	JOIN bill bi ON bi.customer_id = cu.id
	JOIN line_item li ON li.bill_id = bi.id
	JOIN product pr ON li.product_id = pr.id
    JOIN category ca ON ca.id = pr.category_id
GROUP BY ca.label
;

/*-> la liste des produits, avec le nom de leur catégorie, commandés plus de 10 fois en 2022*/
SELECT pr.name, ca.label, SUM(li.quantity) AS cumulQte, COUNT(*)
FROM bill bi 
	JOIN line_item li ON li.bill_id = bi.id
	JOIN product pr ON li.product_id = pr.id
    JOIN category ca ON ca.id = pr.category_id
WHERE YEAR(bi.date) = 2022
GROUP BY pr.name, ca.label
	HAVING cumulQte > 10
;



SELECT pr.name, ca.label, li.quantity
FROM bill bi 
	JOIN line_item li ON li.bill_id = bi.id
	JOIN product pr ON li.product_id = pr.id
    JOIN category ca ON ca.id = pr.category_id
WHERE YEAR(bi.date) = 2022
AND pr.name = 'iusto repellat iure'

;
    


    
SET GLOBAL local_infile=1;

USE netflix;

LOAD DATA LOCAL INFILE 'C:\\formations\\SQL\\netflix.csv'
INTO TABLE import_netflix
FIELDS TERMINATED BY ';'
IGNORE 1 ROWS;

SELECT * FROM import_netflix;

USE formation;

/*
	- Table Learner
		- id
        - name
        - position
        
	- Table Signing
		- id
        - image
        - date
        
	Un learner va avoir des signatures et une signature n'apparatient qu'à un seul Learner
*/

CREATE TABLE Learner (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(150) NOT NULL
);

CREATE TABLE Signing (
	id INT PRIMARY KEY AUTO_INCREMENT,
    image VARCHAR(250) NOT NULL,
    date DATETIME NOT NULL,
    learner_id INT NOT NULL
);


ALTER TABLE Signing
	ADD CONSTRAINT FK_Signing_Learner
    FOREIGN KEY Signing(learner_id)
    REFERENCES Learner(id)
;

/*
*/

SELECT * FROM Learner;


INSERT INTO Learner (name, position)
VALUES ('Fabien', 'Chef'), ('Anais', 'Petite chef'), ('Louis', 'jeune chef')
;

INSERT INTO Signing (image, date, learner_id)
VALUES 
		('sign/Fabien.png', NOW(), 1),
		('sign/Anais.png', NOW(), 2),
		('sign/Louis.png', NOW(), 3)
;

INSERT INTO Signing (image, date, learner_id)
VALUES 
		('sign/Fabien.png', NOW(), 1)
;

/*-> Pour chaque apprenant afficher son nom et le chemin de sa signature*/


SELECT * FROM Learner;
SELECT * FROM Signing;

SELECT *
FROM signing si
	JOIN learner le ON si.learner_id = le.id
ORDER BY learner_id DESC;


SELECT le.name,COUNT(si.id) AS NBSignature
FROM signing si
	JOIN learner le ON si.learner_id = le.id
GROUP BY le.id
ORDER BY learner_id DESC;




USE netflix;

SELECT * FROM movie;
DESCRIBE movie;


SELECT * FROM import_netflix;

INSERT INTO director (lastname, firstname)
VALUES ('toto', 'titi');

SELECT * FROM director;

INSERT INTO movie (title, country, description, release_year, duration, rating, director_id)
SELECT title, country, description, release_year, replace(duration, ' min', ''), rating, 20717
FROM import_netflix
WHERE release_year REGEXP '^[0-9]+$' = 1
AND replace(duration, ' min', '') REGEXP '^[0-9]+$' = 1
;


DROP PROCEDURE dispatch_import_netflix;
DELIMITER //
CREATE PROCEDURE dispatch_import_netflix()
BEGIN

	DELETE FROM movie;
	DELETE FROM director;
    
    INSERT INTO director (firstname, lastname)
	SELECT 
		SUBSTRING_INDEX(director, ' ', 1) AS firstname,
		SUBSTRING_INDEX(director, ' ', -1) AS lastname
	FROM import_netflix
	WHERE release_year REGEXP '^[0-9]+$' = 1
	AND replace(duration, ' min', '') REGEXP '^[0-9]+$' = 1
	;
    
    INSERT INTO movie (title, country, description, release_year, duration, rating, director_id)
	SELECT imn.title, imn.country, imn.description, imn.release_year, replace(imn.duration, ' min', ''), imn.rating, di.id
	FROM import_netflix imn
		JOIN director di ON imn.director = CONCAT(di.firstname, ' ', di.lastname)
	WHERE imn.release_year REGEXP '^[0-9]+$' = 1
	AND replace(imn.duration, ' min', '') REGEXP '^[0-9]+$' = 1
	;


END //


SELECT * FROM movie;
SELECT * FROM director;


SELECT mv.title, di.firstname, di.lastname
FROM movie mv
	JOIN director di ON di.id = mv.director_id
;


CALL dispatch_import_netflix();

SELECT * FROM user;


SELECT * FROM director;

/*
1 - Kirsten 
2 - Johnson
*/

INSERT INTO director (firstname, lastname)
SELECT 
	SUBSTRING_INDEX(director, ' ', 1) AS firstname,
    SUBSTRING_INDEX(director, ' ', -1) AS lastname
    
FROM import_netflix
WHERE release_year REGEXP '^[0-9]+$' = 1
AND replace(duration, ' min', '') REGEXP '^[0-9]+$' = 1
;

SELECT *, CONCAT(firstname, ' ', lastname) FROM director;
SELECT * FROM import_netflix;

SELECT imn.show_id, imn.director, di.*
FROM import_netflix imn
	JOIN director di ON imn.director = CONCAT(di.firstname, ' ', di.lastname)
WHERE release_year REGEXP '^[0-9]+$' = 1
AND replace(duration, ' min', '') REGEXP '^[0-9]+$' = 1
;





DROP PROCEDURE generate_viewings;
DELIMITER //
CREATE PROCEDURE generate_viewings(nbViewing INT)
BEGIN
    
    SET @user_id = (SELECT id FROM user ORDER BY RAND() LIMIT 1);
    SET @movie_id = (SELECT id FROM movie ORDER BY RAND() LIMIT 1);
    
    INSERT INTO viewing (date, movie_id, user_id)
    VALUES (NOW(), @movie_id, @user_id);
    
    IF nbViewing > 0
	THEN CALL generate_viewings(nbViewing - 1);
	END IF;
	
END //

SET max_sp_recursion_depth = 250;

CALL generate_viewings(100);

SELECT * FROM viewing;


USE billings;

WITH factures AS 
     (SELECT cat.label AS categorie, 
	YEAR(bi.date) AS annee, 
    SUM(li.quantity * pr.unit_price) AS total
FROM category cat
	JOIN product pr ON cat.id = pr.category_id
	JOIN line_item li ON li.product_id = pr.id
	JOIN bill bi ON li.bill_id = bi.id
GROUP BY cat.label, YEAR(bi.date))
  

SELECT CASE WHEN GROUPING(categorie) = 1 THEN 'Général' ELSE categorie END, 
       CASE WHEN GROUPING(annee) = 1 THEN 'Sous total' ELSE annee END, 
       SUM(total)
FROM factures
GROUP BY categorie,  annee WITH ROLLUP
;



