-- Užduotims atlikti reikalingos šios sakila duomenų bazės lentos: rental, payment, film_category, 
-- film, actor, address. 
-- USE SAKILA; 


-- 1. Kiek skirtingų prekių buvo išnuomota? 


SELECT DISTINCT COUNT(inventory_id)
FROM inventory;

-- 2. Top 5 klientai, kurie daugiausia kartų naudojosi nuomos paslaugomis. 
-- SU COUNT ir ORDER BY kabutes reikia rasyti per pasvirusias sharp, arba stulpeli su alias daryti per apatini bruksneli:
SELECT 
	customer_id,
    COUNT(*) AS 'Paslaugu suma'
FROM rental
GROUP BY customer_id
ORDER BY `Paslaugu suma` DESC
LIMIT 5;

-- 3. Išrinkti nuomos id, kurių nuomos ir grąžinimo datos sutampa. 
-- REIKIA NAUDOTI DATE 
SELECT 
	rental_id,
	rental_date,
	return_date
FROM rental
WHERE DATE(rental_date) = DATE(return_date)
ORDER BY rental_date DESC;

-- Rezultatas: nuomos id, nuomos data, grąžinimo data. Pateikti mažėjimo tvarka pagal nuomos id (reikalinga papildoma date() funkcija).
 
-- 4. Kuris klientas išleido daugiausia pinigų nuomos paslaugoms? Pateikti tik vieną klientą ir išleistą pinigų sumą. 

SELECT 
	customer_id,
    COUNT(rental_id) AS Didziausias_kiekis
FROM rental
GROUP BY customer_id
ORDER BY Didziausias_kiekis DESC
LIMIT 1;

SELECT
	customer_id,
    SUM(amount) as Money_for_rental
FROM
	payment
GROUP BY customer_id
ORDER BY Money_for_rental DESC
LIMIT 1;

SELECT * FROM rental;

-- su JOIN apskaiciuot butent pinigus ir parodyt vardus ir pavardes:

SELECT c.customer_id,
       c.first_name,
       c.last_name,
       SUM(p.amount) AS total_spent
FROM payment p
JOIN customer c ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 1;

-- 5. Kiek klientų aptarnavo kiekvienas darbuotojas, kiek nuomos paslaugų pardavė ir už kokią vertę? 

SELECT
	staff_id,
    COUNT(DISTINCT customer_id) AS Klientu_kiekis,
    SUM(amount) AS Bendra_suma
FROM payment
GROUP BY staff_id;

-- 5. Kiek klientų aptarnavo kiekvienas darbuotojas, kiek nuomos paslaugų pardavė ir už kokią vertę?
SELECT
	staff_id,
    COUNT(DISTINCT customer_id) AS Customer_number,
    COUNT(rental_id) AS Rental_number,
    SUM(amount) AS Total_amount
FROM
	payment
GROUP BY staff_id;
-- ----------------------------------------------------------------------------
SELECT
	p.staff_id, 
    s.first_name as Staff_first_name, 
    s.last_name as Staff_last_name, 
    COUNT(DISTINCT p.customer_id) as Customer_number,
    COUNT(p.rental_id) as Rental_number,
    SUM(p.amount) as Total_amount
FROM payment p
JOIN staff s ON p.staff_id = s.staff_id
GROUP BY p.staff_id;

-- 6. Į ekraną išvesti visus nuomos id, kurie prasideda '9', suskaičiuoti jų vertę, pateikti nuo mažiausio nuomos id. 

-- NEZINAU KOL KAS

SELECT 
	rental_id,
    SUM(AMOUNT) AS Verte
FROM payment
WHERE rental_id LIKE '9%'
GROUP BY Verte
ORDER BY rental_id ASC;

-- 7. Kurios kategorijos filmų yra mažiausiai? 

SELECT *
FROM film_category;

SELECT 
	category_id,
	COUNT(film_id) AS Filmu_suma
FROM film_category
-- GROUP BY film_category; 

-- 8.

-- SELECT description,
--     title
-- FROM film
-- WHERE rating = 'R'
-- AND description LIKE '%MySQL%';
-- 9. Surasti filmų id, kurių trukmė 46, 47, 48, 49, 50, 51 minutės. 
-- Rezultatas: pateikiamas didėjančia tvarka pagal trukmę. 
SELECT 
	film_id,
    length
FROM film
WHERE length BETWEEN 46 AND 51
ORDER BY length;

-- 10. Į ekraną išvesti filmų pavadinimus, kurie prasideda raidė 'G' ir filmo trukmė 
-- mažesnė nei 70 
-- minučių. 

SELECT 
	title,
    length
FROM film
WHERE title LIKE 'G%'
AND length < 70;

-- 11. Suskaičiuoti, kiek yra aktorių, kurių pirmoji vardo raidė yra 'A', o pirmoji pavardės 
-- raidė 'W'. 

SELECT COUNT(CONCAT (first_name, ' ', last_name)) AS Vardas_Pavarde
FROM actor
WHERE first_name LIKE 'A%' AND last_name LIKE 'W%';

-- 11.1 Kiek yra aktorių, kurių pavardė prasideda ‘A’ arba baigiasi ‘W’?

SELECT
	COUNT(*) AS Pavarde_A_W
FROM actor
WHERE last_name LIKE 'A%' OR last_name LIKE '%W';


-- 12. Suskaičiuoti kiek yra klientų, kurių pavardėje yra dvi O raidės ('OO'). 

SELECT COUNT(*) AS Pavardeje_OO
FROM actor
WHERE last_name LIKE '%oo%';

SELECT 
	last_name AS Pavardeje_OO
FROM actor
WHERE last_name LIKE '%oo%';

-- 13. Kiek rajonuose skirtingų adresų? Pateikti tuos rajonus, kurių adresų skaičius 
-- didesnis arba 
-- lygus 9. 

-- SELECT DISTINCT district
-- FROM ADDRESS;

SELECT district, COUNT(*) AS address_count
FROM address
GROUP BY district;
-- HAVING COUNT(*) > 9;


-- 14. Į ekraną išvesti visus unikalius rajonų pavadinimus, kurie baigiasi raide 'D'. 

SELECT DISTINCT district
FROM address
WHERE district LIKE '%D';

-- 15. Į ekraną išvesti adresus ir rajonus, kurių telefono numeris prasideda ir baigiasi 
-- skaičiumi '9'.

SELECT 
	address,
    district,
    phone
FROM address
WHERE phone LIKE '9%' AND phone LIKE '%9';

-- WHERE phone LIKE '9%9'

