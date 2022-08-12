use sakila;

-- 1. Rank films by length.

select film_id as "Film Id", title as "Title", length, row_number() over (order by length desc) as "Row Number" , rank() over (order by length desc) as "Rank", dense_rank() over (order by length desc) as "Dense Rank" from sakila.film;

-- 2. Rank films by length within the `rating` category.

select title, length, rating, row_number() over(partition by rating order by length desc) as "Row Number", rank() over(partition by rating order by length desc) as "Rank", dense_rank() over(partition by rating order by length desc) as "Dense Rank" from sakila.film;

-- 3.How many films are there for each of the categories in the category table? 

SELECT c.name, count(film_id) as number_of_films from film_category as f join category as c on c.category_id=f.category_id group by c.name;

-- 4. Which actor has appeared in the most films?

select a.actor_id, concat(first_name," ",last_name) as actor, count(*) from sakila.film_actor as fa
join sakila.actor as a  on a.actor_id=fa.actor_id
group by actor_id
order by count(*) desc
limit 1;

-- 5. Most active customer
select concat(first_name," ",last_name) as customer, count(*) from sakila.customer as c
join sakila.rental as r
on c.customer_id=r.customer_id
group by c.customer_id
order by count(*) desc
limit 1;

-- Bonus. Most rented film.
select title, count(*) from sakila.film as f
join sakila.inventory as i
on f.film_id=i.film_id
join sakila.rental as r
on i.inventory_id=r.inventory_id
group by title
order by count(*) desc
limit 1;
