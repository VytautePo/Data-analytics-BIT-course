-- Atlikti žemiau aprašytas užduotis iš sakila duomenų bazės.
-- USE SAKILA;
-- 1. Suskaičiuoti, kiek yra aktorių, kurių pavardės prasideda A ir B raidėmis.
-- Rezultatas: aktorių skaičius ir pavardės pirmąją raidę.

SELECT 
    SUBSTRING(last_name, 1, 1) AS initial,
    COUNT(*) AS actor_count
FROM actor
WHERE last_name LIKE 'A%' OR last_name LIKE 'B%'
GROUP BY SUBSTRING(last_name, 1, 1)
ORDER BY initial;

SELECT *
FROM actor
WHERE last_name LIKE 'A%' OR last_name LIKE 'B%';


-- 2. Suskaičiuoti kiek filmų yra nusifilmavę aktoriai.
-- Rezultatas: filmų skaičius, aktoriaus vardas ir pavardė.
-- Pateikti 10 aktorių, nusifilmavusių daugiausiai filmų (TOP 10).

SELECT
	a.actor_id,
	COUNT(film_id) AS Filmu_skaicius,
	a.first_name,
	a.last_name
FROM
  actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;

SELECT
	a.actor_id,
	COUNT(film_id) AS Filmu_skaicius,
	a.first_name,
	a.last_name
FROM
  actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

-- 2.1 Suskaičiuoti kiek filmų yra nusifilmavę aktoriai.
-- Rezultatas: filmų skaičius, aktoriaus vardas ir pavardė.
-- Pateikti 10 aktorių, nusifilmavusių daugiausiai filmų (TOP 10).
SELECT
  a.actor_id,
  a.first_name,
  a.last_name,
  COUNT(fa.film_id) as movie_count
FROM
  actor a
JOIN film_actor fa 
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY movie_count DESC
LIMIT 10;

-- 3. Nustatyti kokia yra minimali, maksimali ir vidutinė kaina, sumokama už filmą.
-- Rezultatas: pateikti tik minimalią, maksimalią ir vidutinę kainas.

SELECT
MIN(amount) AS Zemiausia_kaina,
MAX(amount) AS Auksciausia_kaina,
AVG(amount) AS Vidutine_kaina
FROM payment;

SELECT * FROM payment;

-- 4. Suskaičiuoti, kiek kiekviena parduotuvė turi klientų.

SELECT
	store_id,
    COUNT(DISTINCT customer_id) AS kLIENTU_KIEKIS
FROM customer
GROUP BY store_id;

-- 5. Suskaičiuoti kiek yra kiekvieno žanro filmų.
-- Rezultatas: filmų skaičius ir žanro pavadinimą. Rezultatą surikiuoti pagal filmų
-- skaičių mažėjimo tvarka.

SELECT
	fc.film_id,
    c.category_id,
    c.name
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id;

SELECT
   COUNT(c.category_id) Filmu_kiekis,
    c.name Zanras
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY Filmu_kiekis DESC;

-- 6. Sužinoti, kuriame filme vaidino daugiausiai aktorių.
-- Rezultatas: filmo pavadinimas ir aktorių skaičius.

SELECT 
	f.film_id,
    f.title,
    COUNT(fa.actor_id) AS Aktoriu_kiekis
FROM film f 
JOIN film_actor fa ON f.film_id = fa.film_id
GROUP BY F.film_id, f.title
ORDER BY Aktoriu_kiekis DESC
LIMIT 1;

-- 7. Pateikti filmus ir juose vaidinusius aktorius.

-- Rezultatas: filmo pavadinimas, aktoriaus vardas ir pavardė. Rezultate turi būti rodomi
-- tik filmai, kurių identifikatoriaus (film_id) reikšmė yra nuo 1 iki 2. Duomenys rūšiuojami pagal 
-- filmo pavadinimą, aktoriaus vardą ir pavardę didėjančia tvarka.


SELECT 
    f.title,
    CONCAT(a.first_name, ' ', a.last_name) AS Aktorius
FROM film f 
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE f.film_id BETWEEN 1 AND 2
ORDER BY title, Aktorius DESC;

-- 8. Suskaičiuoti, kiek filmų yra nusifilmavęs kiekvienas aktorius.
-- Rezultatas: filmų skaičius, aktoriaus vardas, pavardė. Rezultatą surikiuoti pagal filmų
-- skaičių mažėjančia tvarka ir pagal aktoriaus vardą didėjančia tvarka.

SELECT 
	COUNT(fa.film_id) AS Filmu_kiekis,
	a.first_name AS Vardas,
    a.last_name AS Pavarde
FROM film_actor fa 
JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY 
	Filmu_kiekis DESC,
    Vardas ASC;

-- 9. Suskaičiuoti kiek miestų prasideda A, B, C ir D raidėmis. -- Rezultatas: miestų skaičius ir miesto pavadinimo pirmoji raidė.

-- SELECT NEZINAU LEFT funkcijos
--     LEFT(city, 1) AS pirma_raide,
--     COUNT(*) AS miestu_skaicius
-- FROM city
-- WHERE LEFT(city, 1) IN ('A', 'B', 'C', 'D')
-- GROUP BY LEFT(city, 1)
-- ORDER BY pirma_raide;

SELECT 
    SUBSTRING(city, 1, 1) AS Pirma_raide,
    COUNT(*) AS Miestu_skaicius
FROM city
WHERE SUBSTRING(city, 1, 1) IN ('A','B','C','D')
GROUP BY SUBSTRING(city, 1, 1)
ORDER BY Pirma_raide;

-- 10. Suskaičiuoti, kiek kiekvienas klientas yra sumokėjęs pinigų už filmų nuomą.
-- Rezultatas: kliento vardas, pavardė, adresas, apygarda (district) ir sumokėta
-- pinigų suma. Turi būti pateikiami tik tie klientai, kurie yra sumokėję 170 ar didesnę pinigų sumą.

SELECT 
	c.first_name AS Vardas,
    c.last_name AS Pavarde,
    a.address AS Adresas,
    a.district AS Apygarda,
    SUM(p.amount) AS Suma
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
JOIN address a ON c.address_id = a.address_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(p.amount) > 170
ORDER BY Suma DESC;

-- 11. Suskaičiuoti, kiek pinigų už filmus yra sumokėję kiekvienos apygardos klientai
-- kartu.
-- Rezultatas: apygardą (district) ir išleista pinigų suma. Pateikti tik tas apygardas,
-- kurios yra
-- išleidusios daugiau nei 700 pinigų. Duomenis surūšiuoti pagal apygardą didėjančia
-- tvarka.
SELECT
	a.district AS Apygarda,
    SUM(p.amount) AS Suma
FROM address a 
JOIN customer c ON a.address_id = c.address_id
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY a.district
HAVING SUM(p.amount) > 700
ORDER BY Apygarda ASC;

-- 12. Suskaičiuoti, kiek filmų nusifilmavo kiekvienas aktorius priklausomai nuo filmo žanro (kategorijos).
-- Rezultatas: filmų skaičius, aktoriaus vardas ir pavardė, filmo žanras (kategorija).
-- Rezultatą surūšiuoti pagal aktoriaus vardą, pavardę, filmo žanrą didėjančia tvarka.
-- Pirmas mano, antras destytojo.

SELECT
	COUNT(f.film_id) AS Filmu_kiekis,
    CONCAT_WS(' ', a.first_name, a.last_name) AS Aktorius,
    c.name AS Zanras
FROM actor a 
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id, a.actor_id
ORDER BY Aktorius ASC, Filmu_kiekis ASC;

SELECT
    a.first_name,
    a.last_name,
    c.name AS genre,
    COUNT(fa.film_id) AS film_count
FROM actor AS a
INNER JOIN film_actor AS fa
    ON a.actor_id = fa.actor_id
INNER JOIN film_category AS fc
    ON fa.film_id = fc.film_id
INNER JOIN category AS c
    ON fc.category_id = c.category_id
GROUP BY
    a.actor_id,
    a.first_name,
    a.last_name,
    c.category_id,
    c.name
ORDER BY
    a.first_name ASC,
    a.last_name ASC,
    c.name ASC;


-- 13. Suskaičiuoti kiek filmų savo filmo aprašyme turi žodį „drama“. (Kiek kartų žodis pasikartoja nėra svarbu).
-- Rezultatas: tik filmų skaičius ir filmo žanras. Pateikti 
-- tik tuos filmų žanrus, kurie turi 7 ir daugiau filmų,  kuriuose yra žodis „drama“ (filmo aprašymui naudoti lauką iš lentos film_text).

 SELECT
    c.name AS genre,
    COUNT(ft.film_id) AS drama_film_count
FROM film_text AS ft
JOIN film_category AS fc ON ft.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
WHERE
    ft.description LIKE '% drama %'
    OR ft.description LIKE '% drama'
    OR ft.description LIKE 'drama %'
GROUP BY c.name
HAVING COUNT(ft.film_id) >= 7
ORDER BY drama_film_count DESC;

-- 14. Suskaičiuoti kiek klientų yra kiekvienoje šalyje.
-- Rezultatas: klientų skaičius ir šalis. Duomenis surikiuoti pagal klientų skaičių
-- mažėjančia
-- tvarka. Pateikti tik 5 šalis, turinčias daugiausiai klientų.

SELECT
	COUNT(C.customer_id) AS Klientu_kiekis,
	co.country AS Salis
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
GROUP BY co.country_id
ORDER BY Klientu_kiekis DESC
LIMIT 5;

-- 15. Suskaičiuoti kiekvienoje parduotuvėje bendrai visų klientų sumokėtą sumą.
-- Rezultatas: parduotuvės identifikatorius (store_id), parduotuvės adresas, miestas ir
-- šalis,

SELECT 
	s.store_id,
    a.address,
    c.city,
    co.country,
SUM(p.amount) AS Bendra_suma
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id
JOIN customer cu ON s.store_id = cu.store_id
JOIN payment p ON cu.customer_id = p.customer_id
GROUP BY s.store_id, c.city, co.country
ORDER BY s.store_id;
