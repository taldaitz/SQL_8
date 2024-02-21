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
CREATE PROCEDURE updateToDefaultQtyAvailable(stock_default int)
BEGIN
	
    UPDATE product
    SET quantity_available = stock_default;
    
END//


SELECT * FROM product;

CALL updateToDefaultQtyAvailable(100);
