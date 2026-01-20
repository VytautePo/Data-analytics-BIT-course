-- MySQL functions Tasks 
-- BONUS už gražų kodą ir gerą formatavimą, įvairius kodų variantus, kūrybiškumą 
-- USE SAKILA: 
-- Naudoti  


-- 1. Raskite aktorių vardus, kurių pavardė prasideda raide „A“, ir pridėkite simbolių skaičių 
-- prie kiekvieno jų vardo. 

SELECT LENGTH(first_name) AS Simboliu_skaicius,
		first_name,
		actor_id
FROM actor
WHERE first_name LIKE 'A%';

-- 2. Apskaičiuokite kiekvieno kliento nuomos mokesčio vidurkį. 

SELECT customer_id,
ROUND(AVG(amount), 2) AS Vidutinis_mokestis
FROM payment
GROUP BY customer_id
ORDER BY Vidutinis_mokestis DESC;

-- SU JOIN-- 
SELECT 
	CONCAT_WS(' ', c.first_name, c.last_name) AS Vardas_Pavarde,
    ROUND(AVG(amount), 2) AS Vidutinis_mokestis
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY Vardas_Pavarde ASC;


-- 3. Sugrupuokite nuomas pagal metus ir mėnesį bei parodykite jų skaičių. 

SELECT COUNT(rental_id) AS Nuomu_kiekis,
	YEAR(rental_date) AS Metai,
    MONTH(rental_date) AS Menuo
FROM rental
GROUP BY Metai, Menuo;

-- 4. Parodykite klientų vardus su jų bendrais mokėjimais, apvalinant iki dviejų skaitmenų po 
-- kablelio. 

SELECT
	CONCAT(c.first_name, ' ', c.last_name) AS Klientas,
    ROUND(SUM(p.amount), 2) AS Mokejimas
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY Klientas
ORDER BY Klientas ASC;

-- 5.  Rodyti kiekvieną filmą, id, pavadinimo pirmus 2 žodžius ir ar jo trukmė ilgesnė nei 
-- vidutinė (IF) 
 -- SU SUBSTRING, DAR PASIAISKINT DAUGIAU-- 
SELECT 
	film_id,
    SUBSTRING_INDEX(title, ' ', 2) AS Pirmi_2_zodziai,
    length AS Vid_trukme,
	IF(length > (SELECT AVG(length) FROM film), 'Ilgesnė', 'Trumpesnė') AS ilgesne_nei_vidutine
FROM film;



-- 6. Išveskite visas kategorijas ir skaičių filmų, priklausančių kiekvienai kategorijai, bendrą 
-- pelną, vidutinį nuomos įkainį.  

SELECT
	c.category_id,
    c.name AS Kategorija,
    COUNT(DISTINCT f.film_id) AS Filmu_skaicius,
    SUM(p.amount) AS Bendras_pelnas,
    ROUND(AVG(f.rental_rate), 2) AS Vidutinis_ikainis
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
LEFT JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.category_id, c.name
ORDER BY kategorija;

-- 7. Raskite visų nuomų, kurios įvyko darbo dienomis ir savaitgaliais, skaičių ir generuotas 
-- sumas 

-- SELECT r.rental_date,
-- COUNT(r.rental_id) AS Nuomos_skaicius,
-- SUM(p.amount) AS Suma
-- FROM rental r
-- JOIN payment p ON r.rental_id = p.rental_id
-- GROUP BY r.rental_date
-- 	HAVING (SELECT rental_id, DAYOFWEEK(rental_date) AS savaites_diena FROM rental)
	
-- SELECT DISTINCT DAY(rental_date) FROM rental;

-- SELECT rental_id, DAYOFWEEK(rental_date) AS savaites_diena
-- FROM rental;

SELECT
    CASE 
        WHEN WEEKDAY(r.rental_date) < 5 THEN 'Darbo dienos'
        ELSE 'Savaitgalis'
    END AS tipas,
    
    COUNT(*) AS nuomu_kiekis,
    SUM(p.amount) AS sugeneruota_suma
FROM rental r
LEFT JOIN payment p ON r.rental_id = p.rental_id
GROUP BY tipas;

-- Itanas
SELECT
    CASE
        WHEN DAYOFWEEK(r.rental_date) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS rentals_count,
    SUM(p.amount) AS total_revenue
FROM rental AS r
JOIN payment AS p
    ON r.rental_id = p.rental_id
GROUP BY day_type;

-- Modestas KITOKIE REZULTATAI
SELECT
	IF(DAYOFWEEK(r.rental_date) BETWEEN 0 AND 4, 'Darbo_diena', 'Savaitgalis') AS Savaites_diena
    , COUNT(r.rental_id) AS Nuomu_skaicius
    , SUM(p.amount) AS Uzdarbis
    FROM rental r
    JOIN payment p ON r.rental_id = p.rental_id
    GROUP BY Savaites_diena;

-- 8. Išveskite aktorius, kurių vardai yra ilgesni nei 6 simboliai. 

SELECT
	actor_id,
    first_name,
    LENGTH(first_name)
FROM actor
WHERE LENGTH(first_name) > 6;

-- 9. Išveskite filmų pavadinimus kartu su jų kategorijomis, sudarytus viename stulpelyje. 

SELECT CONCAT_WS(' ', f.title, c.name) AS Filmas_su_kategorija
FROM film f 
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
ORDER BY Filmas_su_kategorija;

-- 10. Raskite aktoriaus pilną vardą ir kiek filmų jis (ji) suvaidino. 

SELECT
	CONCAT_WS(' ' , a.first_name, a.last_name) AS Aktorius,
    COUNT(fa.film_id) AS Filmu_kiekis
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY Filmu_kiekis DESC;

-- 11. Parodykite nuomų, kurios buvo grąžintos vėluojant 3 dienas ar daugiau, skaičių. 

SELECT COUNT(*) AS Veluojanciu_filmu_kiekis
FROM rental
WHERE return_date IS NOT NULL
AND DATEDIFF(return_date, rental_date) >= 3;

SELECT COUNT(*) AS Veluojanciu_filmu_kiekis
FROM rental
WHERE DATEDIFF(return_date, rental_date) >= 3;

-- 11.1 Veluojanciu 3 dienas FILMU skaicius:

SELECT COUNT(*) AS veluojanciu_nuomu_sk
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE DATEDIFF(r.return_date, r.rental_date) > f.rental_duration + 3;

-- MODESTO

SELECT COUNT(*) AS veluojanciu_nuomu
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.return_date IS NOT NULL
  AND (DATEDIFF(r.return_date, r.rental_date) - f.rental_duration) > 3; 
-- NEVEIKIA NES SALYGA GAUNASI SU MINUSU 

-- 12. Raskite visų filmų pavadinimų raidžių skaičių vidurkį. 

SELECT 
    ROUND(AVG(LENGTH(title)), 2) AS vidutinis_pavadinimo_ilgis
FROM film;

-- 13. Išveskite klientus, kurių vardai prasideda raide „M“, ir parodykite jų mokėjimų sumą. 

SELECT 
		c.customer_id,
		CONCAT(c.first_name, ' ', c.last_name) AS Klientas,
        SUM(p.amount) AS Mokejimu_suma
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
WHERE c.first_name LIKE 'M%'
GROUP BY c.customer_id, Klientas
ORDER BY Mokejimu_suma DESC;

-- 14. Apskaičiuokite, kokią pajamų dalį sudaro nuomos, kurios truko mažiau nei 5 dienas. 

-- SELECT NESAMONE
-- 	p.payment_id,
--     SUM(p.amount) AS Pajamos
-- FROM payment p
-- JOIN rental r ON p.rental_id = r.rental_id
-- GROUP BY p.payment_id
-- HAVING Pajamos = (SELECT
-- 	rental_id,
-- 	DATEDIFF(return_date, rental_date) AS Nuomos_trukme
-- FROM rental
-- WHERE DATEDIFF(return_date, rental_date) < 5
-- GROUP BY rental_id);

SELECT 
    ROUND(
        SUM(CASE 
                WHEN DATEDIFF(r.return_date, r.rental_date) < 5 
                THEN p.amount 
                ELSE 0 
            END) 
        / SUM(p.amount), 
        2
    ) AS revenue_share_under_5_days
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id;

SELECT 
    ROUND(
        100 * SUM(CASE 
                     WHEN DATEDIFF(r.return_date, r.rental_date) < 5 
                     THEN p.amount 
                     ELSE 0 
                  END) 
        / SUM(p.amount), 
        2
    ) AS pct_of_revenue_under_5_days
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id;


-- 15. Parodykite filmų trukmes, sugrupuotas pagal intervalus (pvz., 0-60 min, 61-120 min ir t. T.

SELECT 
CASE 
	WHEN length BETWEEN 0 AND 60 THEN 'Trumpas 0–60 min'
        WHEN length BETWEEN 61 AND 120 THEN 'Vidutinis 61–120 min'
        WHEN length BETWEEN 121 AND 180 THEN 'Ilgas 121–180 min'
        ELSE 'Labai ilgas 181+ min'
    END AS Filmo_trukmes_intervalas,
COUNT(*) AS filmų_skaičius
FROM film
GROUP BY Filmo_trukmes_intervalas
ORDER BY MIN(length);


-- 16. Klientai su paskutine nuomos data ir jos mėnesiu 

SELECT 
	c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS Klientas,
    MAX(r.rental_date) AS paskutine_nuoma,
    MONTHNAME(MAX(r.rental_date)) AS menuo
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY paskutine_nuoma DESC;
    
    

-- 17. Kiek nuomų atliko kiekvienas klientas (vardas pavardė sujungti) 

SELECT 
	c.customer_id,
    CONCAT_WS(' ', c.first_name, c.last_name) AS klientas,
    COUNT(r.rental_id) AS Nuomu_kiekis
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY customer_id
ORDER BY klientas ASC;

-- 18. Rodyti kiekvienos nuomos trukmę dienomis 

SELECT 
	rental_id,
    DATEDIFF(return_date, rental_date) AS Nuomos_trukme
FROM rental;

-- Su JOIN PARODANT FILMU PAVADINIMUS-- 
SELECT 
	r.rental_id,
    DATEDIFF(r.return_date, r.rental_date) AS Nuomos_trukme,
    f.title
FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY r.rental_id
ORDER BY r.rental_id;

-- 19. Priskirti klientui kategoriją pagal jų generuotas sumas (CASE).

SELECT
	CONCAT_WS(' ', c.first_name, c.last_name) AS Klientas,
    SUM(p.amount) AS Suma,
    
	CASE
		WHEN SUM(p.amount) >= 100 THEN 'Pro'
        WHEN SUM(p.amount) >= 80 THEN 'Standard'
        WHEN SUM(p.amount) >= 50 THEN 'Basic'
        ELSE 'Begginer'
	END AS Kategorija
    
FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY Suma DESC;
