CREATE DATABASE HICOUNSELOR4;

SELECT * FROM hicounselor4.zomato;

-- 1.SQL query to find the top 5 most voted hotels in the delivery category: ----
SELECT name, votes, rating
FROM hicounselor4.zomato
WHERE type = 'Delivery'
ORDER BY votes DESC
LIMIT 5;

-- 2.SQL query to find the top 5 highly rated hotels in the delivery category for a particular location called Banashankari:--

SELECT name, rating, type, location
FROM hicounselor4.zomato
WHERE location = 'Banashankari' AND type = 'Delivery'
ORDER BY rating DESC
LIMIT 5;

-- 3.SQL query to compare the  Firts 10 rows of the cheapest and most expensive hotels in Indiranagar:--
SELECT name, MIN(approx_cost) AS cheapest_rating, MAX(approx_cost) AS expensive_rating
FROM (
    SELECT *
    FROM hicounselor4.zomato
    LIMIT 10
) AS subquery
WHERE location = 'Indiranagar';

-- 3.1.SQL query to compare the  Firts 10 rows ratings of the cheapest and most expensive hotels in Indiranagar:--
-- ------wrking query in sandbox--
SELECT MIN(cheapest.rating) AS cheapest_rating, MAX(expensive.rating) AS expensive_rating
FROM ( SELECT rating FROM hicounselor4.zomato WHERE location = 'Indiranagar' ORDER BY approx_cost ASC LIMIT 1 ) AS cheapest,
( SELECT rating FROM hicounselor4.zomato WHERE location = 'Indiranagar' ORDER BY approx_cost DESC LIMIT 1) AS expensive;
-- ------------------
select 
CASE
    WHEN approx_cost =MIN(approx_cost) then coalesce(rating,'') end as rating1,
    CASE
    WHEN approx_cost =MAX(approx_cost) then coalesce(rating,'') end as rating2
from (select approx_cost,rating,location
FROM hicounselor4.zomato
limit 10)as subqu WHERE location = 'Indiranagar';

-- ------------------

select 
CASE
    WHEN approx_cost =MIN(approx_cost) then (select coalesce(rating,''))  end as mincost_rating,
    CASE
    WHEN approx_cost =MAX(approx_cost) then (select coalesce(rating,'')) end as maxcost_rating
from (select approx_cost,rating,location
FROM hicounselor4.zomato
limit 10)as subqu WHERE location = 'Banashankari';

-- ----------------
select (SELECT rating FROM hicounselor4.zomato WHERE approx_cost = (select min(approx_cost) from hicounselor4.zomato where location = 'Indiranagar') LIMIT 1) AS rating1,
(SELECT rating FROM hicounselor4.zomato WHERE approx_cost = (select MAX(approx_cost) from hicounselor4.zomato where location = 'Indiranagar') LIMIT 1)
as rating2 from hicounselor4.zomato limit 1;
-- ------------------------------------
SELECT MIN(cheapest.rating) AS rating1, MAX(expensive.rating) AS rating2
FROM ( SELECT rating FROM hicounselor4.zomato WHERE location = 'Indiranagar' ORDER BY approx_cost ASC LIMIT 1 ) AS cheapest,
( SELECT rating FROM hicounselor4.zomato WHERE location = 'Indiranagar' ORDER BY approx_cost DESC LIMIT 1 ) AS expensive;





-- 4.SQL query to compare the total votes of restaurants that provide online ordering services and those who don’t provide online ordering service:--
SELECT online_order, SUM(votes) as total_votes
FROM hicounselor4.zomato
GROUP BY online_order;

-- 5.SQL query to find the number of restaurants, total votes, and average rating for each Restaurant type. Display the data with the highest votes on top:--
SELECT SUM(name) as restaurants,SUM(votes) as total_votes,AVG(rating) as average_rating
FROM hicounselor4.zomato
GROUP BY type
ORDER BY votes DESC;

-- 6.SQL query to find the most liked dish of the most-voted restaurant on Zomato:--
SELECT dish_liked,name,rating, votes
FROM hicounselor4.zomato 
WHERE votes = (SELECT MAX(votes) FROM hicounselor4.zomato )
limit 1;

-- --------------
SELECT name, dish_liked,rating,votes 
FROM hicounselor4.zomato
GROUP BY votes
ORDER BY votes DESC
limit 1;

-- 7.SQL query to find the top 15 restaurants which have min 150 votes, have a rating greater than 3, and are currently not providing online ordering. Display the restaurants with highest votes on top:--
SELECT name, votes,online_order
FROM hicounselor4.zomato
WHERE votes >= 150 AND rating >3  AND online_order = 'No'
ORDER BY votes DESC
limit 15;
-- --------------




			





































































































-- 1.SQL query to find the top 5 most voted hotels in the delivery category: ----
SELECT name, rating, votes
FROM hicounselor4.zomato
WHERE online_order = 'Yes'
ORDER BY votes DESC
LIMIT 5;

-- 2.SQL query to find the top 5 highly rated hotels in the delivery category for a particular location called Banashankari:--
SELECT name, rating, votes
FROM hicounselor4.zomatocleaned
WHERE location = 'Banashankari' AND online_order = 'Yes'
ORDER BY rating DESC
LIMIT 5;

-- 3.SQL query to compare the ratings of the cheapest and most expensive hotels in Indiranagar:--
SELECT MIN(rating) as cheapest_rating, MAX(rating) as expensive_rating
FROM hicounselor4.zomatocleaned
WHERE location = 'Indiranagar';

-- 4.SQL query to compare the total votes of restaurants that provide online ordering services and those who don’t provide online ordering service:--
SELECT online_order, SUM(votes) as total_votes
FROM hicounselor4.zomato
GROUP BY online_order;

-- 5.SQL query to find the number of restaurants, total votes, and average rating for each Restaurant type. Display the data with the highest votes on top:--
SELECT rest_type, COUNT(name) as num_restaurants, SUM(votes) as total_votes, AVG(rating) as avg_rating
FROM hicounselor4.zomatocleaned
GROUP BY rest_type
ORDER BY total_votes DESC, rest_type ASC;

-- 6.SQL query to find the most liked dish of the most-voted restaurant on Zomato:--
SELECT dish_liked
FROM hicounselor4.zomatocleaned
WHERE votes = (SELECT MAX(votes) FROM hicounselor4.zomatocleaned)
LIMIT 1;

-- 7.SQL query to find the top 15 restaurants which have min 150 votes, have a rating greater than 3, and are currently not providing online ordering. Display the restaurants with highest votes on top:--
SELECT name, rating, votes
FROM hicounselor4.zomatocleaned
WHERE online_order = 'No' AND votes >= 150 AND rating > 3
ORDER BY votes DESC
LIMIT 15;

