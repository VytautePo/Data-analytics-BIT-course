-- 1. Raskite, kuriame filme vaidino daugiausia aktorių. Rezultatas: Filmo pavadinimas ir aktorių 
-- skaičius.  

SELECT 
    f.title,
    COUNT(fa.actor_id) AS Aktoriu_skaicius
FROM film f 
JOIN film_actor fa ON f.film_id = fa.film_id
GROUP BY f.film_id, f.title
ORDER BY Aktoriu_skaicius
LIMIT 1;

-- 2. Kiek kartų filmas „Academy Dinosaur“ buvo išnuomotas parduotuvėje, kurios ID yra 1? 
-- Rezultatas: Išnuomotų filmų skaičius.  

SELECT 
	f.title,
    COUNT(r.rental_id) AS Nuomu_kiekis,
    s.store_id
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN store s ON i.store_id = s.store_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE f.title LIKE '%ACADEMY DINOSAUR%'
GROUP BY s.store_id, f.title
HAVING s.store_id = 1;

-- PAPRASTESNIS VARIANTAS

SELECT COUNT(r.rental_id) AS rental_count
FROM film AS f
INNER JOIN inventory AS i
    ON f.film_id = i.film_id
INNER JOIN rental AS r
    ON i.inventory_id = r.inventory_id
WHERE
    f.title = 'Academy Dinosaur'
    AND i.store_id = 1;
    
-- 3. Išvardinkite trijų populiariausių filmų pavadinimus. Rezultatas: Filmo pavadinimas, nuomos 
-- kartai.  

SELECT
	f.title AS Filmas,
    COUNT(r.rental_id) AS Nuomos_kiekis
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY Nuomos_kiekis DESC
LIMIT 3;

-- 4. Suskaičiuokite, kiek filmų yra nusifilmavę aktoriai. Rezultatas: Filmų skaičius, aktoriaus 
-- vardas ir pavardė. Papildoma sąlyga: Pateikite 10 aktorių, nusifilmavusių daugiausiai filmų (Top 10).  

SELECT 
	COUNT(fa.film_id) AS Filmu_kiekis,
    CONCAT(a.first_name, ' ', a.last_name) AS Aktorius
FROM film_actor fa
JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY a.actor_id
ORDER BY Filmu_kiekis DESC
LIMIT 10;


-- 5. Suskaičiuokite, kiek yra kiekvieno žanro filmų ir kokia yra vidutinė kiekvieno žanro filmo 
-- trukmė. Rezultatas: Filmų skaičius ir žanro pavadinimas. Papildoma sąlyga: Rezultatus išrikiuokite pagal vidutinę filmo trukmę mažėjimo tvarka.  

SELECT
	COUNT(fc.film_id) AS Filmu_kiekis,
    c.name AS Kategorija,
    ROUND(AVG(f.length), 2) AS Vid_trukme
FROM film f 
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id, Kategorija
ORDER BY Vid_trukme DESC;

-- 6. Pateikite filmus, kurių film_id reikšmė yra nuo 1 iki 5, ir juose vaidinusius aktorius. Rezultatas: 
-- Filmo pavadinimas, aktoriaus vardas ir pavardė. Papildoma sąlyga: Rezultatus išrikiuokite pagal 
-- filmo pavadinimą didėjimo tvarka ir pagal aktoriaus vardą bei pavardę mažėjimo tvarka.  

SELECT
	f.film_id,
	f.title,
    CONCAT(a.first_name, ' ', a.last_name) AS Aktorius
FROM film f 
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE f.film_id BETWEEN 1 AND 5
ORDER BY f.title ASC, Aktorius DESC;

-- 7. Suskaičiuokite, kiek kiekvienas klientas yra sumokėjęs už filmų nuomą. Rezultatas: Kliento 
-- vardas, pavardė, adresas ir sumokėta suma. Papildoma sąlyga: Pateikite tik tuos klientus, kurie 
-- yra sumokėję 170 ar didesnę sumą.  

SELECT
	c.first_name AS Vardas,
    c.last_name AS Pavarde,
    a.address AS Adresas,
    SUM(p.amount) AS Suma
FROM customer c 
JOIN payment p ON c.customer_id = p.customer_id
JOIN address a ON c.address_id = a.address_id
GROUP BY c.customer_id
HAVING Suma >= 170
ORDER BY Suma DESC;

-- 8. Raskite, kiek filmų nusifilmavo kiekvienas aktorius, priklausomai nuo filmo žanro. Rezultatas: 
-- Filmų skaičius, aktoriaus vardas ir pavardė, filmo žanras. Papildoma sąlyga: Rezultatus 
-- išrikiuokite pagal aktoriaus vardą, pavardę ir filmo žanrą didėjimo tvarka.  

SELECT
	COUNT(fa.film_id) AS Filmu_kiekis,
	a.first_name AS vardas,
    a.last_name AS pavarde,
    c.name AS zanras
FROM actor a 
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film_category fc ON fa.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY a.actor_id, c.category_id
ORDER BY vardas, pavarde, zanras;

-- 9. Suskaičiuokite, kiek klientų yra kiekvienoje šalyje. Rezultatas: Šalis ir klientų skaičius. 
-- Papildoma sąlyga: Rezultatus išrikiuokite pagal klientų skaičių mažėjimo tvarka. Pateikite tik 5 
-- šalis, turinčias daugiausiai klientų.  

SELECT 
	co.country AS Salis,
    COUNT(c.customer_id) AS Klientu_kiekis
FROM customer c 
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
GROUP BY co.country_id
ORDER BY Klientu_kiekis DESC
LIMIT 5;

-- 10. Kuris filmas atnešė didžiausias pajamas? Rezultatas: Filmo pavadinimas ir pajamos.  

SELECT
	f.title AS Filmas,
    SUM(p.amount) AS Pajamos
FROM film f 
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.film_id, f.title
ORDER BY Pajamos DESC
LIMIT 1;


-- 11. Kiek kartų buvo nuomojamasi kiekvienoje šalyje? Rezultatas: Šalies pavadinimas, nuomos 
-- kartai. Papildoma sąlyga: Išvardinkite tik tas šalis, kuriose buvo nuomojamasi bent kartą. 
-- Rezultatus išrikiuokite pagal nuomos kartus mažėjimo tvarka.  

SELECT
	co.country AS Salis,
    COUNT(r.rental_id) AS Nuomos_kartai
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
GROUP BY co.country_id, co.country
HAVING COUNT(r.rental_id) >=1
ORDER BY Nuomos_kartai DESC;

-- 12. Kiek kartų kiekviena filmo kategorija buvo išnuomota? Rezultatas: Kategorijos pavadinimas, 
-- nuomos kartai. Papildoma sąlyga: Rezultatus išrikiuokite pagal nuomos kartus mažėjimo tvarka.  

SELECT 
	c.name AS Zanras,
    COUNT(r.rental_id) AS Nuomu_kiekis
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name 
ORDER BY Nuomu_kiekis DESC;

-- 13. Raskite kiekvienoje parduotuvėje bendrai visų klientų sumokėtą sumą. Rezultatas: 
-- Parduotuvės ID, adresas, miestas, šalis ir pajamos.  

-- neteisinga, nes grupuojama pagal staff, o pajamos priskiriamos pagal customer registracija parduotuvei 
SELECT								
	s.store_id AS Parduotuve,
    a.address AS Pard_adresas,
    ci.city AS Miestas,
    co.country AS Salis,
    SUM(p.amount) AS Pajamos
FROM country co
JOIN city ci ON co.country_id = ci.country_id
JOIN address a ON ci.city_id = a.city_id
JOIN store s ON a.address_id = s.address_id
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id, a.address, co.country, ci.city
ORDER BY Pajamos DESC;

-- teisinga, nes jungiasi per customers-- 
SELECT
    s.store_id,
    a.address,
    ci.city,
    co.country,
    SUM(p.amount) AS total_revenue
FROM store AS s
INNER JOIN customer AS c
    ON s.store_id = c.store_id
INNER JOIN payment AS p
    ON c.customer_id = p.customer_id
INNER JOIN address AS a
    ON s.address_id = a.address_id
INNER JOIN city AS ci
    ON a.city_id = ci.city_id
INNER JOIN country AS co
    ON ci.country_id = co.country_id
GROUP BY
    s.store_id,
    a.address,
    ci.city,
    co.country
ORDER BY s.store_id;


-- 14. Išvardinkite lankytojus, kurie nuomavosi „sci-fi“ žanro filmus daugiau nei du kartus. 
-- Rezultatas: Lankytojo vardas, pavardė, nuomos kartai. Papildoma sąlyga: Rezultatus išrikiuokite 
-- pagal nuomos kartus didėjimo tvarka.

SELECT 	
	CONCAT(c.first_name, ' ', c.last_name) AS Lankytojas,
    COUNT(r.rental_id) AS Nuomos_kartai
FROM customer c 
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category ca ON fc.category_id = ca.category_id
WHERE ca.name = 'Sci-Fi'
GROUP BY c.customer_id, Lankytojas
HAVING COUNT(r.rental_id) > 2
ORDER BY Nuomos_kartai ASC;

    